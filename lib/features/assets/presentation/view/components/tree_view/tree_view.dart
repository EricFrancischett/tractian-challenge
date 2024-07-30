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
  late ScrollController _scrollController;
  List<TreeNode> displayedNodes = [];
  final int _increment = 20;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _loadMoreNodes();
  }

  void _onScroll() {
    if (_scrollController.position.pixels <=
        _scrollController.position.maxScrollExtent - 100) {
      _loadMoreNodes();
    }
  }

  void _loadMoreNodes() {
    setState(() {
      final startIndex = displayedNodes.length;
      final endIndex =
          (displayedNodes.length + _increment).clamp(0, widget.nodes.length);
      displayedNodes.addAll(widget.nodes.getRange(startIndex, endIndex));
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: ListView.separated(
        controller: _scrollController,
        itemCount: displayedNodes.length,
        itemBuilder: (context, index) {
          return TreeViewBuilder.buildNode(displayedNodes[index], context);
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