import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:tractian_challenge/core/error/exceptions.dart';
import 'package:tractian_challenge/core/generics/resource.dart';

abstract class AssetLocalDataSource {
  Future<Resource<List<dynamic>, Exception>> getAssets(
      {required String assetFilePath});
}

class AssetLocalDataSourceImpl implements AssetLocalDataSource {
  @override
  Future<Resource<List<dynamic>, Exception>> getAssets(
      {required String assetFilePath}) async {
    try {
      final jsonAssetsString = await rootBundle.loadString(
        assetFilePath,
      );
      final List<dynamic> jsonAssetsResponse = json.decode(
        jsonAssetsString,
      );
      return Resource.success(data: jsonAssetsResponse);
    } on FlutterError catch (error) {
      if (error.message.contains('Unable to load asset') == true) {
        return Resource.failed(
          error: FileNotFoundException(
            message: 'Asset file not found: $error',
          ),
        );
      }
      return Resource.failed(
        error: UnknownException(
          message: 'Unknown error: $error',
        ),
      );
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
