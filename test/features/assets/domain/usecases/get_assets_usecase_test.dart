import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:tractian_challenge/core/entities/asset/asset_entity.dart';
import 'package:tractian_challenge/core/generics/resource.dart';
import 'package:tractian_challenge/core/generics/status.dart';
import 'package:tractian_challenge/features/assets/domain/repositories/asset_repository.dart';
import 'package:tractian_challenge/features/assets/domain/usecases/get_assets_usecase.dart';

main() {
  group(
    'GetAssetsUsecase Tests',
    () {
      final repositoryStub = AssetRepositoryStub();

      String mockJsonPath = 'assets/units/test_unit/assets.json';

      GetIt.instance.registerFactory<AssetRepository>(() => repositoryStub);

      final sut = DefaultGetAssetsUsecase();

      final List<AssetEntity> assetsDummy = [
        AssetEntity(
          id: '6a9b4171b62cbf0062dd8a67',
          name: 'Corn Cooking Facility',
          parentId: null,
        ),
        AssetEntity(
          id: '6a9b41afa2555c0067916b94',
          name: 'Mixer for Soaking',
          parentId: '6a9b4171b62cbf0062dd8a67',
        ),
      ];

      test(
        "Error - when AssetRepository returns an error, it should "
        "return an error with a `failed` status, null data, and a "
        "Exception error type",
        () async {
          //Given
          repositoryStub.resource = Resource.failed(error: Exception());
          //When
          final resource = await sut.call(assetFilePath: mockJsonPath);
          //Then
          expect(resource.status, Status.failed);
          expect(resource.data, null);
          expect(resource.error, isA<Exception>());
        },
      );

      test(
         "Success - when AssetRepository returns a success, it should "
        "return a success with a `success` status, a List of AssetEntity, "
        "null error",
        () async {
          //Given
          repositoryStub.resource = Resource.success(data: assetsDummy);
          //When
          final resource = await sut.call(assetFilePath: mockJsonPath);
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

class AssetRepositoryStub implements AssetRepository {
  late Resource<List<AssetEntity>, Exception> resource;

  @override
  Future<Resource<List<AssetEntity>, Exception>> getAssets(
      {required String assetFilePath}) async {
    return resource;
  }
}
