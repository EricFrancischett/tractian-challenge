import 'package:get_it/get_it.dart';
import 'package:tractian_challenge/core/entities/asset/asset_entity.dart';
import 'package:tractian_challenge/core/error/exceptions.dart';
import 'package:tractian_challenge/core/generics/resource.dart';
import 'package:tractian_challenge/features/assets/domain/repositories/asset_repository.dart';

class GetAssetsUsecase {
  AssetRepository assetRepository = GetIt.I<AssetRepository>();

  Future<Resource<List<AssetEntity>, Exception>> call(
      {required String assetFilePath}) async {
    try {
      final resource =
          await assetRepository.getAssets(assetFilePath: assetFilePath);
      if (resource.hasError) {
        return Resource.failed(error: resource.error);
      } else {
        final List<AssetEntity> jsonAssets = resource.data!;
        return Resource.success(data: jsonAssets);
      }
    } catch (error) {
      return Resource.failed(
        error: UnknownException(
          message: 'Unknown error: $error',
        ),
      );
    }
  }
}
