import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:tractian_challenge/common/generics/resource.dart';

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
    } catch (error) {
      return Resource.failed(error: Exception(error));
    }
  }
}
