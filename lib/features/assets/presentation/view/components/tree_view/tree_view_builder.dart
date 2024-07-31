import 'package:flutter/material.dart';
import 'package:tractian_challenge/core/entities/tree_node/tree_node.dart';
import 'package:tractian_challenge/features/assets/presentation/view/components/tree_view/components/tree_expansion_tile.dart';
import 'package:tractian_challenge/features/assets/presentation/view/components/tree_view/components/tree_list_tile.dart';

class TreeViewBuilder {
  static Widget buildNode(TreeNode node, BuildContext context) {
    if (node.children.isEmpty) {
      return TreeListTile(
        node: node,
      );
    } else {
      return TreeExpansionTile(
        node: node,
      );
    }
  }

  static ListTileThemeData customListTileThemeData = const ListTileThemeData(
    horizontalTitleGap: 0,
    minLeadingWidth: 0,
    minVerticalPadding: 0,
  );
}
