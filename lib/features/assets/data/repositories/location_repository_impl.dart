import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:tractian_challenge/core/entities/location/location_entity.dart';
import 'package:tractian_challenge/core/error/exceptions.dart';
import 'package:tractian_challenge/core/generics/resource.dart';
import 'package:tractian_challenge/features/assets/data/datasources/location_local_datasource.dart';
import 'package:tractian_challenge/features/assets/domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  LocationLocalDataSource localDataSource = GetIt.I<LocationLocalDataSource>();

  @override
  Future<Resource<List<LocationEntity>, Exception>> getLocations(
      {required String locationsFilePath}) async {
    try {
      final resource = await localDataSource.getLocations(
          locationsFilePath: locationsFilePath);
      if (resource.hasError) {
        return Resource.failed(error: resource.error);
      } else {
        final List<Map<String, dynamic>> jsonLocations = resource.data!;
        final List<LocationEntity> locations =
            await compute(parseLocations, jsonLocations);
        return Resource.success(data: locations);
      }
    } on TypeError catch (error) {
      return Resource.failed(
        error: InvalidFormatException(
          message: 'Invalid JSON format: $error',
        ),
      );
    } catch (error) {
      return Resource.failed(
        error: UnknownException(
          message: 'Unknown error: $error',
        ),
      );
    }
  }
}

List<LocationEntity> parseLocations(List<Map<String, dynamic>> jsonLocations) {
  return jsonLocations.map((json) => LocationEntity.fromJson(json)).toList();
}
