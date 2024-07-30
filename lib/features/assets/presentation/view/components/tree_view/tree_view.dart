import 'package:flutter/material.dart';
import 'package:tractian_challenge/core/constants/colors_constants.dart';
import 'package:tractian_challenge/core/entities/tree_node/tree_node.dart';
import 'package:tractian_challenge/features/assets/presentation/view/components/tree_view/tree_view_builder.dart';

class TreeView extends StatefulWidget {
  final List<TreeNode> nodes;

  const TreeView({
    super.key,
    required this.nodes,
  });

  @override
  State<TreeView> createState() => _TreeViewState();
}

class _TreeViewState extends State<TreeView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: ListView.separated(
        itemCount: widget.nodes.length,
        itemBuilder: (context, index) {
          final node = widget.nodes[index];
          return TreeViewBuilder.buildNode(node, context);
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
