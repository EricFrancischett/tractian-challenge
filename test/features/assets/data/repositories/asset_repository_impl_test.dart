import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:tractian_challenge/core/entities/asset/asset_entity.dart';
import 'package:tractian_challenge/core/generics/resource.dart';
import 'package:tractian_challenge/core/generics/status.dart';
import 'package:tractian_challenge/features/assets/data/datasources/asset_local_datasource.dart';
import 'package:tractian_challenge/features/assets/data/repositories/asset_repository_impl.dart';

main() {
  group(
    'AssetRepositoryImpl Tests',
    () {
      final dataSourceStub = AssetLocalDataSourceStub();

      String mockJsonPath = 'assets/units/test_unit/assets.json';

      GetIt.instance
          .registerFactory<AssetLocalDataSource>(() => dataSourceStub);

      final sut = AssetRepositoryImpl();

      final List<Map<String, dynamic>> assetsDummy = [
        {
          "name": "Sensor 14 - energy",
          "id": "6a9b41a1b62cbf0062dd8a6f",
          "locationId": "6a9b41afa2555c0067916b94",
          "parentId": null,
          "sensorType": "energy",
          "status": "operating"
        },
        {
          "name": "Sensor 15 - energy",
          "id": "6a9b41dbb62cbf0062dd8a72",
          "locationId": "6a9b41afa2555c0067916b94",
          "parentId": null,
          "sensorType": "energy",
          "status": "operating"
        }
      ];

      test(
        "Error - when AssetLocalDataSource returns an error, it should "
        "return an error with a `failed` status, null data, and a "
        "Exception error type",
        () async {
          //Given
          dataSourceStub.resource = Resource.failed(error: Exception());
          //When
          final resource = await sut.getAssets(assetFilePath: mockJsonPath);
          //Then
          expect(resource.status, Status.failed);
          expect(resource.data, null);
          expect(resource.error, isA<Exception>());
        },
      );

      test(
        "Success - when AssetLocalDataSource returns a success, it should "
        "return a success with a `success` status, a List of AssetEntity, "
        "null error",
        () async {
          //Given
          dataSourceStub.resource = Resource.success(data: assetsDummy);
          //When
          final resource = await sut.getAssets(assetFilePath: mockJsonPath);
          //Then
          expect(resource.status, Status.success);
          expect(resource.data, isA<List<AssetEntity>>());
          expect(resource.data?.length, 2);
          expect(resource.error, null);
        },
      );
    },
  );
}

class AssetLocalDataSourceStub implements AssetLocalDataSource {
  late Resource<List<Map<String, dynamic>>, Exception> resource;

  @override
  Future<Resource<List<Map<String, dynamic>>, Exception>> getAssets(
      {required String assetFilePath}) async {
    return resource;
  }
}
