import 'package:flutter/material.dart';
import 'package:tractian_challenge/entities/asset/asset_entity.dart';
import 'package:tractian_challenge/entities/location/location_entity.dart';
import 'package:tractian_challenge/tree/tree_node.dart';

class TreeView extends StatelessWidget {
  final List<TreeNode> nodes;

  const TreeView({
    super.key,
    required this.nodes,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: nodes.map((node) => _buildNode(node)).toList(),
    );
  }

  Widget _buildNode(TreeNode node) {
    if (node.children.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: ListTile(
          title: Text('${_getType(node.data)} - ${_getNodeName(node.data)}'),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: ExpansionTile(
          title: Text('${_getType(node.data)} - ${_getNodeName(node.data)}'),
          children: node.children.map((child) => _buildNode(child)).toList(),
        ),
      );
    }
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

  String _getType(dynamic data) {
    if (data is AssetEntity) {
      return 'A';
    } else if (data is LocationEntity) {
      return 'L';
    } else {
      return 'Unknown';
    }
  }
}
