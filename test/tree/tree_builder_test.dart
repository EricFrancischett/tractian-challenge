import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tractian_challenge/entities/asset/asset_entity.dart';
import 'package:tractian_challenge/entities/location/location_entity.dart';
import 'package:tractian_challenge/tree/tree_builder.dart';
import 'package:tractian_challenge/tree/tree_node.dart';

void main() {
  test('TreeBuilderTest', () {
    const assetsJson = '''
  [
    {
      "name": "Sensor 14 - energy",
      "id": "6a9b41a1b62cbf0062dd8a6f",
      "locationId": "6a9b41afa2555c0067916b94",
      "parentId": null,
      "sensorType": "energy",
      "status": "operating"
    },
    {
      "name": "Sensor 15 - energy",
      "id": "6a9b41dbb62cbf0062dd8a72",
      "locationId": "6a9b41afa2555c0067916b94",
      "parentId": null,
      "sensorType": "energy",
      "status": "operating"
    }
  ]
  ''';

    const locationsJson = '''
  [
    {
      "name": "Corn Cooking Facility",
      "id": "6a9b4171b62cbf0062dd8a67",
      "parentId": null
    },
    {
      "name": "Mixer for Soaking",
      "parentId": "6a9b4171b62cbf0062dd8a67",
      "id": "6a9b41afa2555c0067916b94"
    }
  ]
  ''';

    final List<dynamic> assetsList = jsonDecode(assetsJson);
    final List<dynamic> locationsList = jsonDecode(locationsJson);

    final List<AssetEntity> assets =
        assetsList.map((json) => AssetEntity.fromJson(json)).toList();
    final List<LocationEntity> locations =
        locationsList.map((json) => LocationEntity.fromJson(json)).toList();

    final List<TreeNode> treeNodes = TreeBuilder.buildTree(assets, locations);

    for (var node in treeNodes) {
      printNode(node, 0);
    }
  });
}

void printNode(TreeNode node, int depth) {
  final indent = ' ' * depth * 2;
  print('-------');
  print('$indent${node.data.name}');
  for (var child in node.children) {
    printNode(child, depth + 1);
  }
}
