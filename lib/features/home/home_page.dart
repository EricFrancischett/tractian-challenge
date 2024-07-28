import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tractian_challenge/constants/units_assets_constants.dart';
import 'package:tractian_challenge/entities/asset/asset_entity.dart';
import 'package:tractian_challenge/entities/location/location_entity.dart';
import 'package:tractian_challenge/tree/tree_builder.dart';
import 'package:tractian_challenge/tree/tree_node.dart';
import 'package:tractian_challenge/tree/tree_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<TreeNode>> futureTreeNodes;

  @override
  void initState() {
    super.initState();
    futureTreeNodes = loadTreeNodes();
  }

  Future<List<TreeNode>> loadTreeNodes() async {
    // Load assets and locations
    final jsonAssetsString =
        await rootBundle.loadString(UnitsAssetsConstants.tobiasAssets);
    final List<dynamic> jsonAssetsResponse = json.decode(jsonAssetsString);
    final List<AssetEntity> assets =
        jsonAssetsResponse.map((json) => AssetEntity.fromJson(json)).toList();

    // Assuming locations are provided similarly
    final jsonLocationsString =
        await rootBundle.loadString(UnitsAssetsConstants.tobiasLocations);
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
        title: const Text('Asset Tree'),
      ),
      body: FutureBuilder<List<TreeNode>>(
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
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: HomePage(),
  ));
}
