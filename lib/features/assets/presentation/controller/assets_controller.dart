// ignore_for_file: library_private_types_in_public_api

import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:tractian_challenge/common/entities/asset/asset_entity.dart';
import 'package:tractian_challenge/common/entities/location/location_entity.dart';
import 'package:tractian_challenge/features/assets/domain/usecases/get_assets_usecase.dart';
import 'package:tractian_challenge/features/assets/domain/usecases/get_locations_usecase.dart';

import 'package:tractian_challenge/features/assets/presentation/view/helpers/tree_builder.dart';
import 'package:tractian_challenge/common/entities/tree_node/tree_node.dart';
import 'package:tractian_challenge/features/assets/presentation/view/helpers/node_data_helper.dart';
import 'package:tractian_challenge/common/enums/units_enum.dart';

part 'assets_controller.g.dart';

class AssetsController = _AssetsControllerBase with _$AssetsController;

abstract class _AssetsControllerBase with Store {
  GetAssetsUsecase getAssetsUsecase = GetIt.I<GetAssetsUsecase>();
  GetLocationsUsecase getLocationsUsecase = GetIt.I<GetLocationsUsecase>();

  @observable
  String searchQuery = '';

  @observable
  bool showEnergySensors = false;

  @observable
  bool showCriticalStatus = false;

  @observable
  ObservableFuture<List<TreeNode<dynamic>>>? futureTreeNodes;

  @action
  void setSearchQuery(String value) {
    searchQuery = value;
  }

  @action
  void setShowEnergySensors(bool value) {
    showEnergySensors = value;
  }

  @action
  void setShowCriticalStatus(bool value) {
    showCriticalStatus = value;
  }

  @action
  Future<void> loadTreeNodes(UnitsEnum unit) async {
    try {
      final resourceAssets =
          await getAssetsUsecase.call(assetFilePath: unit.assets);
      final resourceLocations =
          await getLocationsUsecase.call(locationsFilePath: unit.locations);

      if (resourceAssets.hasError || resourceLocations.hasError) {
        final Object? error = resourceAssets.error ?? resourceLocations.error;
        futureTreeNodes = ObservableFuture.error(
            error ?? Exception('An error occurred while fetching data.'));
      } else {
        final List<AssetEntity> assets = resourceAssets.data!;
        final List<LocationEntity> locations = resourceLocations.data!;

        // Build the tree
        final treeNodes = TreeBuilder.buildTree(assets, locations);
        futureTreeNodes = ObservableFuture.value(treeNodes);
      }
    } catch (error) {
      futureTreeNodes = ObservableFuture.error(error);
    }
  }

  @computed
  List<TreeNode<dynamic>> get filteredNodes {
    if (futureTreeNodes == null || futureTreeNodes!.value == null) {
      return [];
    }

    final nodes = futureTreeNodes!.value!;
    return _filterTree(nodes);
  }

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
      return node; // If the current node matches the query and filters, return it.
    }

    List<TreeNode<dynamic>> matchingChildren = [];
    for (var child in node.children) {
      final matchingChild = _containsQuery(child, query);
      if (matchingChild != null) {
        matchingChildren.add(matchingChild); // Add only the matching children.
      }
    }

    if (matchingChildren.isNotEmpty) {
      return TreeNode<dynamic>(
          data: node.data,
          children:
              matchingChildren); // Return the node with matching children.
    }

    return null; // If neither the node nor its children match the query and filters, return null.
  }
}
