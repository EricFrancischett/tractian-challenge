import 'package:flutter/material.dart';
import 'package:tractian_challenge/core/constants/colors_constants.dart';
import 'package:tractian_challenge/core/entities/tree_node/tree_node.dart';
import 'package:tractian_challenge/features/assets/domain/enums/component_sensor_type_enum.dart';
import 'package:tractian_challenge/features/assets/domain/enums/component_status_enum.dart';
import 'package:tractian_challenge/features/assets/domain/enums/node_type_enum.dart';
import 'package:tractian_challenge/features/assets/presentation/view/helpers/node_data_helper.dart';

class NodeTitleWidget extends StatelessWidget {
  final TreeNode node;
  const NodeTitleWidget({
    super.key,
    required this.node,
  });

  @override
  Widget build(BuildContext context) {
    
    NodeTypeEnum? type = NodeDataHelper.getNodeType(node.data);
    ComponentSensorTypeEnum? sensorType =
        NodeDataHelper.getComponentSensorType(node.data);
    ComponentStatusEnum? status = NodeDataHelper.getComponentStatus(node.data);

    return Row(
      children: [
        if (type != null) ...{
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: NodeDataHelper.getIconByType(type)!,
          ),
        },
        if (sensorType != null || status != null) ...{
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (sensorType == ComponentSensorTypeEnum.energy)
                  const Icon(
                    Icons.offline_bolt_rounded,
                    color: ColorsConstants.lightGreen,
                    size: 14,
                  ),
                if (status == ComponentStatusEnum.alert)
                  const Icon(
                    Icons.error_rounded,
                    color: ColorsConstants.lightRed,
                    size: 14,
                  ),
              ],
            ),
          ),
        },
        const SizedBox(
          width: 4,
        ),
        Expanded(
          child: Text(
            NodeDataHelper.getNodeName(node.data),
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
