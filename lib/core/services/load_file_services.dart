import 'dart:convert';
import 'package:flutter/services.dart';

class LoadFileServices {
  static Future<List<dynamic>> loadFile(String path) async {
    final jsonString = await rootBundle.loadString(
      path,
    );
    final List<dynamic> jsonAssetsResponse = json.decode(
      jsonString,
    );
    return jsonAssetsResponse;
  }
}
