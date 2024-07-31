import 'dart:convert';
import 'package:flutter/services.dart';

class LoadFileServices {
  static Future<List<Map<String, dynamic>>> loadFile(String path) async {
    final jsonString = await rootBundle.loadString(
      path,
    );
    final jsonAssetsResponse = json.decode(
      jsonString,
    );

    final List<Map<String, dynamic>> mapListResponse =
        List<Map<String, dynamic>>.from(
      jsonAssetsResponse,
    );
    return mapListResponse;
  }
}
