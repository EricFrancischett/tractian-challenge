import 'package:flutter/material.dart';

class ColorsConstants {
  const ColorsConstants();

  static const darkBlue = Color(0xFF17192D);
  static const lightBlue = Color(0xFF2188FF);
  static const white = Color(0xFFFFFFFF);
  static const lightGray = Color(0xFFF2F2F2);
  static const gray = Color(0xFFC8C8C8);
  static const transparent = Color(0x00000000);
  static const lightGreen = Color(0xFFA5D149);
  static const lightRed = Color(0xFFE54C4C);

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
