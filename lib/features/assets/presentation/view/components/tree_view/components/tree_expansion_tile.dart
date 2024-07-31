import 'package:flutter/material.dart';
import 'package:tractian_challenge/core/constants/colors_constants.dart';
import 'package:tractian_challenge/core/entities/tree_node/tree_node.dart';
import 'package:tractian_challenge/features/assets/presentation/view/components/tree_view/components/node_title_widget.dart';
import 'package:tractian_challenge/features/assets/presentation/view/components/tree_view/tree_view_builder.dart';

class TreeExpansionTile extends StatelessWidget {
  final TreeNode node;
  const TreeExpansionTile({
    super.key,
    required this.node,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: ColorsConstants.transparent,
      ),
      child: ListTileTheme(
        data: TreeViewBuilder.customListTileThemeData,
        child: ExpansionTile(
          controlAffinity: ListTileControlAffinity.leading,
          tilePadding: const EdgeInsets.symmetric(vertical: 6),
          visualDensity: VisualDensity.compact,
          childrenPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
          minTileHeight: 0,
          dense: false,
          title: NodeTitleWidget(
            node: node,
          ),
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: node.children.length,
              itemBuilder: (context, index) {
                final childNode = node.children[index];
                return TreeViewBuilder.buildNode(childNode, context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
