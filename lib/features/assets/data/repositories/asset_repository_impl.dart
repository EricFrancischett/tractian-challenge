import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:tractian_challenge/core/entities/asset/asset_entity.dart';
import 'package:tractian_challenge/core/error/exceptions.dart';
import 'package:tractian_challenge/core/generics/resource.dart';
import 'package:tractian_challenge/features/assets/data/datasources/asset_local_datasource.dart';
import 'package:tractian_challenge/features/assets/domain/repositories/asset_repository.dart';

class AssetRepositoryImpl implements AssetRepository {
  AssetLocalDataSource assetLocalDataSource = GetIt.I<AssetLocalDataSource>();

  @override
  Future<Resource<List<AssetEntity>, Exception>> getAssets(
      {required String assetFilePath}) async {
    try {
      final resource =
          await assetLocalDataSource.getAssets(assetFilePath: assetFilePath);
      if (resource.hasError) {
        return Resource.failed(error: resource.error);
      } else {
        final List<Map<String, dynamic>> jsonAssets = resource.data!;
        final List<AssetEntity> assets = await compute(parseAssets, jsonAssets);
        return Resource.success(data: assets);
      }
    } on TypeError catch (error) {
      return Resource.failed(
        error: InvalidFormatException(
          message: 'Invalid JSON format: $error',
        ),
      );
    } catch (error) {
      return Resource.failed(
        error: UnknownException(
          message: 'Unknown error: $error',
        ),
      );
    }
  }
}

List<AssetEntity> parseAssets(List<Map<String, dynamic>> jsonAssets) {
  return jsonAssets.map((json) => AssetEntity.fromJson(json)).toList();
}
