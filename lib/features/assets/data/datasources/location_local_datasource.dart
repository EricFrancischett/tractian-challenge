import 'dart:convert';
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
    } on PlatformException catch (error) {
      return Resource.failed(
        error: FileNotFoundException(
          message: 'Location file not found: $error',
        ),
      );
    } on FormatException catch (error) {
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
