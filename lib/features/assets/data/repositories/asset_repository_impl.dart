import 'package:get_it/get_it.dart';
import 'package:tractian_challenge/common/entities/asset/asset_entity.dart';
import 'package:tractian_challenge/features/assets/data/datasources/asset_local_datasource.dart';
import 'package:tractian_challenge/features/assets/domain/repositories/asset_repository.dart';

class AssetRepositoryImpl implements AssetRepository {
  AssetLocalDataSource assetLocalDataSource = GetIt.I<AssetLocalDataSource>();

  @override
  Future<List<AssetEntity>> getAssets({required String assetFilePath}) async {
    try {
      final List<dynamic> jsonAssets =
          await assetLocalDataSource.getAssets(assetFilePath: assetFilePath);
      final List<AssetEntity> assets =
          jsonAssets.map((json) => AssetEntity.fromJson(json)).toList();
      return assets;
    } catch (error) {
      throw Exception('Error loading assets: $error');
    }
  }
}
