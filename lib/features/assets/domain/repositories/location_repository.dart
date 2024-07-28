import 'package:tractian_challenge/common/entities/location/location_entity.dart';
import 'package:tractian_challenge/common/generics/resource.dart';

abstract class LocationRepository {
  Future<Resource<List<LocationEntity>, Exception>> getLocations(
      {required String locationsFilePath});
}
