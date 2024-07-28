import 'package:tractian_challenge/entities/location/location_entity_keys.dart';

class LocationEntity {
  final String name;
  final String id;
  final String? parentId;

  LocationEntity({
    required this.name,
    required this.id,
    this.parentId,
  });

  factory LocationEntity.fromJson(Map<String, dynamic> json) {
    return LocationEntity(
      name: json[LocationEntityKeys.name],
      id: json[LocationEntityKeys.id],
      parentId: json[LocationEntityKeys.parentId],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      LocationEntityKeys.name: name,
      LocationEntityKeys.id: id,
      LocationEntityKeys.parentId: parentId,
    };
  }
}
