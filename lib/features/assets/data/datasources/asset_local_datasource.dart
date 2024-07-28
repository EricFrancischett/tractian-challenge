import 'dart:convert';
import 'package:flutter/services.dart';

abstract class AssetLocalDataSource {
  Future<List<dynamic>> getAssets({required String assetFilePath});
}

class AssetLocalDataSourceImpl implements AssetLocalDataSource {
  @override
  Future<List<dynamic>> getAssets({required String assetFilePath}) async {
    try {
      final jsonAssetsString = await rootBundle.loadString(assetFilePath);
      final List<dynamic> jsonAssetsResponse = json.decode(jsonAssetsString);
      return jsonAssetsResponse;
    } catch (error) {
      throw Exception('Error loading assets: $error');
    }
  }
}
