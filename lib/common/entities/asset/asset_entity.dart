import 'package:tractian_challenge/common/entities/asset/asset_entity_keys.dart';

class AssetEntity {
  final String name;
  final String id;
  final String? locationId;
  final String? parentId;
  final String? sensorType;
  final String? status;

  AssetEntity({
    required this.name,
    required this.id,
    this.locationId,
    this.parentId,
    this.sensorType,
    this.status,
  });

  factory AssetEntity.fromJson(Map<String, dynamic> json) {
    return AssetEntity(
      name: json[AssetEntityKeys.name],
      id: json[AssetEntityKeys.id],
      locationId: json[AssetEntityKeys.locationId],
      parentId: json[AssetEntityKeys.parentId],
      sensorType: json[AssetEntityKeys.sensorType],
      status: json[AssetEntityKeys.status],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AssetEntityKeys.name: name,
      AssetEntityKeys.id: id,
      AssetEntityKeys.locationId: locationId,
      AssetEntityKeys.parentId: parentId,
      AssetEntityKeys.sensorType: sensorType,
      AssetEntityKeys.status: status,
    };
  }
}
