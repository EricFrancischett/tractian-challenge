import 'package:flutter/material.dart';
import 'package:tractian_challenge/core/entities/tree_node/tree_node.dart';
import 'package:tractian_challenge/features/assets/presentation/view/components/tree_view/components/node_title_widget.dart';
import 'package:tractian_challenge/features/assets/presentation/view/components/tree_view/tree_view_builder.dart';

class TreeListTile extends StatelessWidget {
  final TreeNode node;
  const TreeListTile({
    super.key,
    required this.node,
  });

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      data: TreeViewBuilder.customListTileThemeData,
      child: ListTile(
        visualDensity: VisualDensity.compact,
        contentPadding: const EdgeInsets.symmetric(vertical: 6),
        minTileHeight: 0,
        leading: const SizedBox(
          width: 24,
        ),
        title: NodeTitleWidget(
          node: node,
        ),
      ),
    );
  }
}
