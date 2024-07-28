import 'package:tractian_challenge/common/entities/location/location_entity.dart';

abstract class LocationRepository {
  Future<List<LocationEntity>> getLocations({required String locationsFilePath});
}
