import 'package:flutter/material.dart';
import 'package:tractian_challenge/entities/asset/asset_entity.dart';
import 'package:tractian_challenge/entities/location/location_entity.dart';
import 'package:tractian_challenge/entities/tree_node/tree_node.dart';

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
    NodeType? type = _getType(node.data);
    SensorType? sensorType = _getSensorType(node.data);
    Status? status = _getStatys(node.data);
    if (node.children.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: ListTile(
          leading: getIconByType(type),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (sensorType == SensorType.energy)
                const Icon(
                  Icons.bolt,
                  color: Colors.green,
                ),
              if (status == Status.alert)
                const Icon(
                  Icons.warning,
                  color: Colors.red,
                ),
            ],
          ),
          title: Text(
            _getNodeName(node.data),
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: ExpansionTile(
          leading: getIconByType(type),
          title: Text(
            _getNodeName(node.data),
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
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

  NodeType? _getType(dynamic data) {
    if (data is LocationEntity) {
      return NodeType.location;
    } else if (data is AssetEntity) {
      if (data.sensorType != null) {
        return NodeType.component;
      } else {
        return NodeType.asset;
      }
    } else {
      return null;
    }
  }

  Widget? getIconByType(NodeType? type) {
    switch (type) {
      case NodeType.asset:
        return const Icon(Icons.crop_square);
      case NodeType.location:
        return const Icon(Icons.place);
      case NodeType.component:
        return const Icon(Icons.crop_16_9);
      default:
        return null;
    }
  }

  SensorType? _getSensorType(dynamic data) {
    if (data is AssetEntity) {
      String? sensorType = data.sensorType;
      if (sensorType != null) {
        if (sensorType == 'energy') {
          return SensorType.energy;
        } else if (sensorType == 'vibration') {
          return SensorType.vibration;
        }
      }
    }
    return null;
  }

  Status? _getStatys(dynamic data) {
    if (data is AssetEntity) {
      String? status = data.status;
      if (status != null) {
        if (status == 'alert') {
          return Status.alert;
        } else if (status == 'operating') {
          return Status.operating;
        }
      }
    }
    return null;
  }
}

enum NodeType {
  asset,
  location,
  component,
}

enum SensorType {
  energy,
  vibration,
}

enum Status {
  alert,
  operating,
}
