import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:tractian_challenge/common/generics/resource.dart';

abstract class AssetLocalDataSource {
  Future<Resource<List<dynamic>, Exception>> getAssets(
      {required String assetFilePath});
}

class AssetLocalDataSourceImpl implements AssetLocalDataSource {
  @override
  Future<Resource<List<dynamic>, Exception>> getAssets(
      {required String assetFilePath}) async {
    try {
      final jsonAssetsString = await rootBundle.loadString(assetFilePath);
      final List<dynamic> jsonAssetsResponse = json.decode(jsonAssetsString);
      return Resource.success(data: jsonAssetsResponse);
    } catch (error) {
      return Resource.failed(error: Exception(error));
    }
  }
}
