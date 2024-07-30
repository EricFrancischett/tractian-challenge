import 'package:flutter/material.dart';

class ColorsConstants {
  const ColorsConstants();

  static const darkBlue = Color(0xFF17192D);
  static const lightBlue = Color(0xFF2188FF);
  static const white = Color(0xFFFFFFFF);
  static const gray = Color(0xFFEAEFF3);
  static const darkGray = Color(0xFF8E98A3);

  static const homeGradient = LinearGradient(
    colors: [
      darkBlue,
      lightBlue,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.4, 1],
  );
}
