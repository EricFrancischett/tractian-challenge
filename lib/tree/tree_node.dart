class TreeNode<T> {
  final T data;
  final List<TreeNode<T>> children;

  TreeNode({required this.data, this.children = const []});
}