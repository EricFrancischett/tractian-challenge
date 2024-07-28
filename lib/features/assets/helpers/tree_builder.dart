import 'package:tractian_challenge/common/entities/asset/asset_entity.dart';
import 'package:tractian_challenge/common/entities/location/location_entity.dart';
import 'package:tractian_challenge/common/entities/tree_node/tree_node.dart';

class TreeBuilder {
  static List<TreeNode<dynamic>> buildTree(
      List<AssetEntity> assets, List<LocationEntity> locations) {
    final Map<String, TreeNode<dynamic>> nodeMap = {};

    // Create nodes for locations
    for (var location in locations) {
      nodeMap[location.id] = TreeNode<dynamic>(data: location, children: []);
    }

    // Create nodes for assets and components
    for (var asset in assets) {
      nodeMap[asset.id] = TreeNode<dynamic>(data: asset, children: []);
    }

    // Helper function to add child nodes to parents
    void addChildToParent(String childId, String? parentId) {
      if (parentId == null || !nodeMap.containsKey(parentId)) return;

      final parentNode = nodeMap[parentId]!;
      final childNode = nodeMap[childId]!;

      // Only add the child if it's not already in the parent's children list
      if (!parentNode.children.contains(childNode)) {
        parentNode.children.add(childNode);
      }
    }

    // Assign children to locations
    for (var location in locations) {
      if (location.parentId != null) {
        addChildToParent(location.id, location.parentId);
      }
    }

    // Assign assets and components to their respective parents
    for (var asset in assets) {
      if (asset.locationId != null) {
        addChildToParent(asset.id, asset.locationId);
      } else if (asset.parentId != null) {
        addChildToParent(asset.id, asset.parentId);
      }
    }

    // Find root nodes (nodes without parents)
    final List<TreeNode<dynamic>> rootNodes = [];
    for (var node in nodeMap.values) {
      if ((node.data is LocationEntity &&
              (node.data as LocationEntity).parentId == null) ||
          (node.data is AssetEntity &&
              node.data.locationId == null &&
              node.data.parentId == null)) {
        rootNodes.add(node);
      }
    }

    return rootNodes;
  }
}
