import 'package:flutter/material.dart';
import 'package:tractian_challenge/core/constants/colors_constants.dart';
import 'package:tractian_challenge/core/entities/tree_node/tree_node.dart';
import 'package:tractian_challenge/features/assets/presentation/view/components/tree_view/tree_view_builder.dart';

class TreeView extends StatelessWidget {
  final List<TreeNode> nodes;

  const TreeView({
    super.key,
    required this.nodes,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: ListView.separated(
        itemCount: nodes.length,
        itemBuilder: (context, index) {
          return TreeViewBuilder.buildNode(nodes[index], context);
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
}
