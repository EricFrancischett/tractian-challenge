import 'package:tractian_challenge/entities/location/location_entity_keys.dart';

class Location {
  final String name;
  final String id;
  final String? parentId;

  Location({
    required this.name,
    required this.id,
    this.parentId,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
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
