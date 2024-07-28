import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:tractian_challenge/core/error/exceptions.dart';
import 'package:tractian_challenge/core/generics/resource.dart';

abstract class LocationLocalDataSource {
  Future<Resource<List<dynamic>, Exception>> getLocations(
      {required String locationsFilePath});
}

class LocationLocalDataSourceImpl implements LocationLocalDataSource {
  @override
  Future<Resource<List<dynamic>, Exception>> getLocations(
      {required String locationsFilePath}) async {
    try {
      final jsonLocationsString =
          await rootBundle.loadString(locationsFilePath);
      final List<dynamic> jsonLocationsResponse =
          json.decode(jsonLocationsString);
      return Resource.success(data: jsonLocationsResponse);
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
