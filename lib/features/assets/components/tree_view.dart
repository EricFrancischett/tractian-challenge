import 'package:flutter/material.dart';
import 'package:tractian_challenge/common/entities/asset/asset_entity.dart';
import 'package:tractian_challenge/common/entities/location/location_entity.dart';
import 'package:tractian_challenge/common/entities/tree_node/tree_node.dart';
import 'package:tractian_challenge/features/assets/enums/component_sensor_type_enum.dart';
import 'package:tractian_challenge/features/assets/enums/component_status_enum.dart';
import 'package:tractian_challenge/features/assets/enums/node_type_enum.dart';

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
    NodeTypeEnum? type = _getType(node.data);
    ComponentSensorTypeEnum? sensorType = _getSensorType(node.data);
    ComponentStatusEnum? status = _getStatys(node.data);
    if (node.children.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: ListTile(
          leading: getIconByType(type),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (sensorType == ComponentSensorTypeEnum.energy)
                const Icon(
                  Icons.bolt,
                  color: Colors.green,
                ),
              if (status == ComponentStatusEnum.alert)
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

  NodeTypeEnum? _getType(dynamic data) {
    if (data is LocationEntity) {
      return NodeTypeEnum.location;
    } else if (data is AssetEntity) {
      if (data.sensorType != null) {
        return NodeTypeEnum.component;
      } else {
        return NodeTypeEnum.asset;
      }
    } else {
      return null;
    }
  }

  Widget? getIconByType(NodeTypeEnum? type) {
    switch (type) {
      case NodeTypeEnum.asset:
        return const Icon(Icons.crop_square);
      case NodeTypeEnum.location:
        return const Icon(Icons.place);
      case NodeTypeEnum.component:
        return const Icon(Icons.crop_16_9);
      default:
        return null;
    }
  }

  ComponentSensorTypeEnum? _getSensorType(dynamic data) {
    if (data is AssetEntity) {
      String? sensorType = data.sensorType;
      if (sensorType != null) {
        if (sensorType == 'energy') {
          return ComponentSensorTypeEnum.energy;
        } else if (sensorType == 'vibration') {
          return ComponentSensorTypeEnum.vibration;
        }
      }
    }
    return null;
  }

  ComponentStatusEnum? _getStatys(dynamic data) {
    if (data is AssetEntity) {
      String? status = data.status;
      if (status != null) {
        if (status == 'alert') {
          return ComponentStatusEnum.alert;
        } else if (status == 'operating') {
          return ComponentStatusEnum.operating;
        }
      }
    }
    return null;
  }
}




