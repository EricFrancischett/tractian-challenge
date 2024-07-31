import 'package:tractian_challenge/core/entities/location/location_entity.dart';
import 'package:tractian_challenge/core/generics/resource.dart';

abstract class LocationRepository {
  Future<Resource<List<LocationEntity>, Exception>> getLocations(
      {required String locationsFilePath});
}
