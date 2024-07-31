import 'package:flutter/material.dart';
import 'package:tractian_challenge/features/assets/presentation/view/assets_page.dart';
import 'package:tractian_challenge/features/home/presentation/view/home_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String assets = '/assets';

  static Map<String, WidgetBuilder> routes = {
    home: (context) => const HomePage(),
    assets: (context) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      return AssetsPage(unit: args[assetPageUnitKey]);
    },
  };

  static const String assetPageUnitKey = 'unit';
}
