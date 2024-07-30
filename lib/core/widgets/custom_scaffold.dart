import 'package:flutter/material.dart';
import 'package:tractian_challenge/core/constants/colors_constants.dart';
import 'package:tractian_challenge/core/widgets/custom_app_bar.dart';

class CustomScaffold extends StatelessWidget {
  final String pageTitle;
  final EdgeInsetsGeometry padding;
  final Widget body;
  const CustomScaffold({
    super.key,
    required this.pageTitle,
    this.padding = const EdgeInsets.all(24.0),
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: pageTitle,
      ),
      backgroundColor: ColorsConstants.white,
      body: SafeArea(
        child: Padding(
          padding: padding,
          child: body,
        ),
      ),
    );
  }
}
