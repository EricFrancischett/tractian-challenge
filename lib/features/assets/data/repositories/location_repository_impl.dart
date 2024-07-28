import 'package:get_it/get_it.dart';
import 'package:tractian_challenge/common/entities/location/location_entity.dart';
import 'package:tractian_challenge/features/assets/data/datasources/location_local_datasource.dart';
import 'package:tractian_challenge/features/assets/domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  LocationLocalDataSource localDataSource = GetIt.I<LocationLocalDataSource>();

  @override
  Future<List<LocationEntity>> getLocations(
      {required String locationsFilePath}) async {
    try {
      final List<dynamic> jsonLocations = await localDataSource.getLocations(
          locationsFilePath: locationsFilePath);
      final List<LocationEntity> locations =
          jsonLocations.map((json) => LocationEntity.fromJson(json)).toList();
      return locations;
    } catch (error) {
      throw Exception('Error loading assets: $error');
    }
  }
}
