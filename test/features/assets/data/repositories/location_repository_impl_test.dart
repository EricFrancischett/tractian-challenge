import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:tractian_challenge/core/entities/location/location_entity.dart';
import 'package:tractian_challenge/core/generics/resource.dart';
import 'package:tractian_challenge/core/generics/status.dart';
import 'package:tractian_challenge/features/assets/data/datasources/location_local_datasource.dart';
import 'package:tractian_challenge/features/assets/data/repositories/location_repository_impl.dart';

main() {
  group(
    'LocationRepositoryImpl Tests',
    () {
      final dataSourceStub = LocationLocalDataSourceStub();

      String mockJsonPath = 'assets/units/test_unit/locations.json';

      GetIt.instance
          .registerFactory<LocationLocalDataSource>(() => dataSourceStub);

      final sut = LocationRepositoryImpl();

      final List<dynamic> assetsDummy = [
        {
          "name": "Corn Cooking Facility",
          "id": "6a9b4171b62cbf0062dd8a67",
          "parentId": null
        },
        {
          "name": "Mixer for Soaking",
          "parentId": "6a9b4171b62cbf0062dd8a67",
          "id": "6a9b41afa2555c0067916b94"
        }
      ];

      test(
        "Error - when LocationLocalDataSource returns an error, it should "
        "return an error with a `failed` status, null data, and a "
        "Exception error type",
        () async {
          //Given
          dataSourceStub.resource = Resource.failed(error: Exception());
          //When
          final resource =
              await sut.getLocations(locationsFilePath: mockJsonPath);
          //Then
          expect(resource.status, Status.failed);
          expect(resource.data, null);
          expect(resource.error, isA<Exception>());
        },
      );

      test(
        "Success - when LocationLocalDataSource returns a success, it should "
        "return a success with a `success` status, a List of LocationEntity, "
        "null error",
        () async {
          //Given
          dataSourceStub.resource = Resource.success(data: assetsDummy);
          //When
          final resource =
              await sut.getLocations(locationsFilePath: mockJsonPath);
          //Then
          expect(resource.status, Status.success);
          expect(resource.data, isA<List<LocationEntity>>());
          expect(resource.data?.length, 2);
          expect(resource.error, null);
        },
      );
    },
  );
}

class LocationLocalDataSourceStub implements LocationLocalDataSource {
  late Resource<List<dynamic>, Exception> resource;

  @override
  Future<Resource<List, Exception>> getLocations(
      {required String locationsFilePath}) async {
    return resource;
  }
}
