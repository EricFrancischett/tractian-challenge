// ignore_for_file: library_private_types_in_public_api

import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:tractian_challenge/core/entities/asset/asset_entity.dart';
import 'package:tractian_challenge/core/entities/location/location_entity.dart';
import 'package:tractian_challenge/features/assets/domain/usecases/get_assets_usecase.dart';
import 'package:tractian_challenge/features/assets/domain/usecases/get_locations_usecase.dart';
import 'package:tractian_challenge/features/assets/presentation/view/helpers/tree_builder.dart';
import 'package:tractian_challenge/core/entities/tree_node/tree_node.dart';
import 'package:tractian_challenge/features/assets/presentation/view/helpers/node_data_helper.dart';
import 'package:tractian_challenge/core/enums/units_enum.dart';

part 'assets_controller.g.dart';

class AssetsController = _AssetsControllerBase with _$AssetsController;

abstract class _AssetsControllerBase with Store {
  // Use cases for getting assets and locations
  GetAssetsUsecase getAssetsUsecase = GetIt.I<GetAssetsUsecase>();
  GetLocationsUsecase getLocationsUsecase = GetIt.I<GetLocationsUsecase>();

  // Observable properties for search query, filters, and tree nodes
  @observable
  String searchQuery = '';

  @observable
  bool showEnergySensors = false;

  @observable
  bool showCriticalStatus = false;

  @observable
  ObservableFuture<List<TreeNode<dynamic>>>? futureTreeNodes;

  // Action to set the search query
  @action
  void setSearchQuery(String value) {
    searchQuery = value;
  }

  // Action to toggle the energy sensors filter
  @action
  void setShowEnergySensors(bool value) {
    showEnergySensors = value;
  }

  // Action to toggle the critical status filter
  @action
  void setShowCriticalStatus(bool value) {
    showCriticalStatus = value;
  }

  // Action to load tree nodes based on the selected unit
  @action
  Future<void> loadTreeNodes(UnitsEnum unit) async {
    try {
      // Fetch assets and locations using the use cases
      final resourceAssets =
          await getAssetsUsecase.call(assetFilePath: unit.assets);
      final resourceLocations =
          await getLocationsUsecase.call(locationsFilePath: unit.locations);

      // Handle errors if any
      if (resourceAssets.hasError || resourceLocations.hasError) {
        final Object? error = resourceAssets.error ?? resourceLocations.error;
        futureTreeNodes = ObservableFuture.error(
          error ?? Exception('An error occurred while fetching data.'),
        );
      } else {
        // Build the tree nodes from assets and locations
        final List<AssetEntity> assets = resourceAssets.data!;
        final List<LocationEntity> locations = resourceLocations.data!;
        final treeNodes = TreeBuilder.buildTree(assets, locations);

        // Set the futureTreeNodes observable with the built tree nodes
        futureTreeNodes = ObservableFuture.value(treeNodes);
      }
    } catch (error) {
      // Handle any other errors that may occur
      futureTreeNodes = ObservableFuture.error(error);
    }
  }

  // Computed property to get the filtered nodes based on search query and filters
  @computed
  List<TreeNode<dynamic>> get filteredNodes {
    if (futureTreeNodes == null || futureTreeNodes!.value == null) {
      return [];
    }

    final nodes = futureTreeNodes!.value!;
    return _filterTree(nodes);
  }

  // Method to filter the tree nodes based on search query and filters
  List<TreeNode<dynamic>> _filterTree(List<TreeNode<dynamic>> nodes) {
    if (searchQuery.isEmpty && !showEnergySensors && !showCriticalStatus) {
      return nodes;
    }

    List<TreeNode<dynamic>> filteredNodes = [];
    for (var node in nodes) {
      final matchingNode = _containsQuery(node, searchQuery);
      if (matchingNode != null) {
        filteredNodes.add(matchingNode);
      }
    }
    return filteredNodes;
  }

  // Method to check if a node or its children match the search query and filters
  TreeNode<dynamic>? _containsQuery(TreeNode<dynamic> node, String query) {
    bool matchesFilter = true;
    if (showEnergySensors) {
      matchesFilter = NodeDataHelper.matchesEnergySensorFilter(node.data);
    }
    if (showCriticalStatus) {
      matchesFilter = matchesFilter &&
          NodeDataHelper.matchesCriticalStatusFilter(node.data);
    }

    if (NodeDataHelper.getNodeName(node.data)
            .toLowerCase()
            .contains(query.toLowerCase()) &&
        matchesFilter) {
      return node;
    }

    List<TreeNode<dynamic>> matchingChildren = [];
    for (var child in node.children) {
      final matchingChild = _containsQuery(child, query);
      if (matchingChild != null) {
        matchingChildren.add(matchingChild);
      }
    }

    if (matchingChildren.isNotEmpty) {
      return TreeNode<dynamic>(data: node.data, children: matchingChildren);
    }

    return null;
  }
}
