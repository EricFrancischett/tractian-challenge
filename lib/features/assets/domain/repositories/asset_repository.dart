import 'package:tractian_challenge/common/entities/asset/asset_entity.dart';

abstract class AssetRepository {
  Future<List<AssetEntity>> getAssets({required String assetFilePath});
}
