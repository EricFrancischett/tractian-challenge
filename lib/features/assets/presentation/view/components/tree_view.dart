import 'package:flutter/material.dart';
import 'package:tractian_challenge/core/entities/tree_node/tree_node.dart';
import 'package:tractian_challenge/features/assets/domain/enums/component_sensor_type_enum.dart';
import 'package:tractian_challenge/features/assets/domain/enums/component_status_enum.dart';
import 'package:tractian_challenge/features/assets/domain/enums/node_type_enum.dart';
import 'package:tractian_challenge/features/assets/presentation/view/helpers/node_data_helper.dart';

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
    NodeTypeEnum? type = NodeDataHelper.getNodeType(node.data);
    ComponentSensorTypeEnum? sensorType =
        NodeDataHelper.getComponentSensorType(node.data);
    ComponentStatusEnum? status = NodeDataHelper.getComponentStatus(node.data);
    if (node.children.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: ListTile(
          leading: NodeDataHelper.getIconByType(type),
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
            NodeDataHelper.getNodeName(node.data),
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
          leading: NodeDataHelper.getIconByType(type),
          title: Text(
            NodeDataHelper.getNodeName(node.data),
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
          children: node.children.map((child) => _buildNode(child)).toList(),
        ),
      );
    }
  }
}
