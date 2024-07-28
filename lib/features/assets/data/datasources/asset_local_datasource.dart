import 'dart:convert';
import 'package:flutter/services.dart';

class AssetLocalDataSource {
  Future<List<Map<String, dynamic>>> getAssets(String assetFilePath) async {
    try {
      final jsonAssetsString = await rootBundle.loadString(assetFilePath);
      final List<Map<String, dynamic>> jsonAssetsResponse =
          json.decode(jsonAssetsString);
      return jsonAssetsResponse;
    } catch (error) {
      throw Exception('Error loading assets: $error');
    }
  }
}
