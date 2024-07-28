import 'package:get_it/get_it.dart';
import 'package:tractian_challenge/common/entities/asset/asset_entity.dart';
import 'package:tractian_challenge/features/assets/domain/repositories/asset_repository.dart';

class GetAssetsUsecase {
  AssetRepository assetRepository = GetIt.I<AssetRepository>();

  Future<List<AssetEntity>> call({required String assetFilePath}) async {
    return await assetRepository.getAssets(assetFilePath: assetFilePath);
  }
}
