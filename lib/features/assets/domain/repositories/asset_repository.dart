import 'package:tractian_challenge/core/entities/asset/asset_entity.dart';
import 'package:tractian_challenge/core/generics/resource.dart';

abstract class AssetRepository {
  Future<Resource<List<AssetEntity>, Exception>> getAssets(
      {required String assetFilePath});
}
