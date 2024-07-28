import 'package:tractian_challenge/common/entities/asset/asset_entity.dart';
import 'package:tractian_challenge/common/generics/resource.dart';

abstract class AssetRepository {
  Future<Resource<List<AssetEntity>, Exception>> getAssets(
      {required String assetFilePath});
}
