import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tractian_challenge/entities/asset/asset_entity.dart';
import 'package:tractian_challenge/entities/location/location_entity.dart';
import 'package:tractian_challenge/features/assets/helpers/tree_builder.dart';
import 'package:tractian_challenge/entities/tree_node/tree_node.dart';
import 'package:tractian_challenge/features/assets/components/tree_view.dart';

class AssetsPage extends StatefulWidget {
  final String unitLocations;
  final String unitAssets;
  const AssetsPage({
    super.key,
    required this.unitLocations,
    required this.unitAssets,
  });

  @override
  State<AssetsPage> createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> {
  late Future<List<TreeNode<dynamic>>> futureTreeNodes;
  late TextEditingController _searchController;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(_onSearchChanged);
    futureTreeNodes = loadTreeNodes();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
    });
  }

  Future<List<TreeNode<dynamic>>> loadTreeNodes() async {
    // Load assets and locations
    final jsonAssetsString = await rootBundle.loadString(widget.unitAssets);
    final List<dynamic> jsonAssetsResponse = json.decode(jsonAssetsString);
    final List<AssetEntity> assets =
        jsonAssetsResponse.map((json) => AssetEntity.fromJson(json)).toList();

    final jsonLocationsString =
        await rootBundle.loadString(widget.unitLocations);
    final List<dynamic> jsonLocationsResponse =
        json.decode(jsonLocationsString);
    final List<LocationEntity> locations = jsonLocationsResponse
        .map((json) => LocationEntity.fromJson(json))
        .toList();

    // Build the tree
    return TreeBuilder.buildTree(assets, locations);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<TreeNode<dynamic>> _filterTree(List<TreeNode<dynamic>> nodes) {
    if (_searchQuery.isEmpty) {
      return nodes;
    }

    List<TreeNode<dynamic>> filteredNodes = [];
    for (var node in nodes) {
      final matchingNode = _containsQuery(node, _searchQuery);
      if (matchingNode != null) {
        filteredNodes.add(matchingNode);
      }
    }
    return filteredNodes;
  }

  TreeNode<dynamic>? _containsQuery(TreeNode<dynamic> node, String query) {
    if (_getNodeName(node.data).toLowerCase().contains(query.toLowerCase())) {
      return node; // If the current node matches the query, return it.
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

    return null; // If neither the node nor its children match the query, return null.
  }

  String _getNodeName(dynamic data) {
    if (data is AssetEntity) {
      return data.name;
    } else if (data is LocationEntity) {
      return data.name;
    } else {
      return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assets'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              labelText: 'Search',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: CheckboxListTile(
                  title: const Text('Energia'),
                  value: false,
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CheckboxListTile(
                  title: const Text('Critico'),
                  value: false,
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: FutureBuilder<List<TreeNode<dynamic>>>(
              future: futureTreeNodes,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No assets found.'));
                } else {
                  final filteredNodes = _filterTree(snapshot.data!);
                  return TreeView(nodes: filteredNodes);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
