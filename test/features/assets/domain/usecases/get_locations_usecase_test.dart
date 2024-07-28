import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:tractian_challenge/core/entities/location/location_entity.dart';
import 'package:tractian_challenge/core/generics/resource.dart';
import 'package:tractian_challenge/core/generics/status.dart';
import 'package:tractian_challenge/features/assets/domain/repositories/location_repository.dart';
import 'package:tractian_challenge/features/assets/domain/usecases/get_locations_usecase.dart';

main() {
  group(
    'GetLocationsUsecase Tests',
    () {
      final repositoryStub = LocationRepositoryStub();

      String mockJsonPath = 'assets/units/test_unit/assets.json';

      GetIt.instance.registerFactory<LocationRepository>(() => repositoryStub);

      final sut = GetLocationsUsecase();

      final List<LocationEntity> assetsDummy = [
        LocationEntity(
          id: '6a9b4171b62cbf0062dd8a67',
          name: 'Corn Cooking Facility',
          parentId: null,
        ),
        LocationEntity(
          id: '6a9b41afa2555c0067916b94',
          name: 'Mixer for Soaking',
          parentId: '6a9b4171b62cbf0062dd8a67',
        ),
      ];

      test(
        "Error - when LocationRepository returns an error, it should "
        "return an error with a `failed` status, null data, and a "
        "Exception error type",
        () async {
          //Given
          repositoryStub.resource = Resource.failed(error: Exception());
          //When
          final resource = await sut.call(locationsFilePath: mockJsonPath);
          //Then
          expect(resource.status, Status.failed);
          expect(resource.data, null);
          expect(resource.error, isA<Exception>());
        },
      );

      test(
        "Success - when LocationRepository returns a success, it should "
        "return a success with a `success` status, a List of LocationEntity, "
        "null error",
        () async {
          //Given
          repositoryStub.resource = Resource.success(data: assetsDummy);
          //When
          final resource = await sut.call(locationsFilePath: mockJsonPath);
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

class LocationRepositoryStub implements LocationRepository {
  late Resource<List<LocationEntity>, Exception> resource;

  @override
  Future<Resource<List<LocationEntity>, Exception>> getLocations(
      {required String locationsFilePath}) async {
    return resource;
  }
}
