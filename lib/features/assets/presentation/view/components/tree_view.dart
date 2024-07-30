import 'package:flutter/material.dart';
import 'package:tractian_challenge/core/constants/colors_constants.dart';
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
    // return ListView(
    //   children: nodes.map((node) => _buildNode(node, context)).toList(),
    // );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: ListView.separated(
        itemCount: nodes.length,
        itemBuilder: (context, index) {
          return _buildNode(nodes[index], context);
        },
        separatorBuilder: (context, index) => const SizedBox(
          height: 20,
          child: Center(
            child: Divider(
              color: ColorsConstants.newGray,
              height: 1,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNode(TreeNode node, BuildContext context) {
    NodeTypeEnum? type = NodeDataHelper.getNodeType(node.data);
    ComponentSensorTypeEnum? sensorType =
        NodeDataHelper.getComponentSensorType(node.data);
    ComponentStatusEnum? status = NodeDataHelper.getComponentStatus(node.data);
    if (node.children.isEmpty) {
      return ListTileTheme(
        data: const ListTileThemeData(
          horizontalTitleGap: 0,
          minLeadingWidth: 0,
          minVerticalPadding: 0,
        ),
        child: ListTile(
          visualDensity: VisualDensity.compact,
          contentPadding: const EdgeInsets.symmetric(vertical: 6),
          minTileHeight: 0,
          leading: const SizedBox(
            width: 24,
          ),
          title: Row(
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
          ),
        ),
      );
    } else {
      return Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ListTileTheme(
          data: const ListTileThemeData(
            horizontalTitleGap: 0,
            minLeadingWidth: 0,
            minVerticalPadding: 0,
          ),
          child: ExpansionTile(
            controlAffinity: ListTileControlAffinity.leading,
            tilePadding: const EdgeInsets.symmetric(vertical: 6),
            visualDensity: VisualDensity.compact,
            childrenPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
            minTileHeight: 0,
            dense: false,
            title: Row(
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
            ),
            children: node.children
                .map((child) => _buildNode(child, context))
                .toList(),
          ),
        ),
      );
    }
  }
}
