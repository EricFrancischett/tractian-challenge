import 'package:flutter/material.dart';
import 'package:tractian_challenge/app_widget.dart';
import 'package:tractian_challenge/get_it.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GetItServiceLocator.setUp();
  runApp(const AppWidget());
}
