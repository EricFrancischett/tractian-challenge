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
  late Future<List<TreeNode>> futureTreeNodes;

  @override
  void initState() {
    super.initState();
    futureTreeNodes = loadTreeNodes();
  }

  Future<List<TreeNode>> loadTreeNodes() async {
    // Load assets and locations
    final jsonAssetsString = await rootBundle.loadString(widget.unitAssets);
    final List<dynamic> jsonAssetsResponse = json.decode(jsonAssetsString);
    final List<AssetEntity> assets =
        jsonAssetsResponse.map((json) => AssetEntity.fromJson(json)).toList();

    // Assuming locations are provided similarly
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assets'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const TextField(
            decoration: InputDecoration(
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
            child: FutureBuilder<List<TreeNode>>(
              future: futureTreeNodes,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No assets found.'));
                } else {
                  return TreeView(nodes: snapshot.data!);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
