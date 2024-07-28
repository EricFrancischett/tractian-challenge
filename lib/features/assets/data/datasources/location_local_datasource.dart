import 'dart:convert';
import 'package:flutter/services.dart';

abstract class LocationLocalDataSource {
  Future<List<dynamic>> getLocations({required String locationsFilePath});
}

class LocationLocalDataSourceImpl implements LocationLocalDataSource {
  @override
  Future<List<dynamic>> getLocations(
      {required String locationsFilePath}) async {
    try {
      final jsonLocationsString =
          await rootBundle.loadString(locationsFilePath);
      final List<dynamic> jsonLocationsResponse =
          json.decode(jsonLocationsString);
      return jsonLocationsResponse;
    } catch (error) {
      throw Exception('Error loading assets: $error');
    }
  }
}
