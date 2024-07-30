import 'package:flutter/material.dart';
import 'package:tractian_challenge/core/widgets/custom_app_bar.dart';

class CustomScaffold extends StatelessWidget {
  final String? pageTitle;
  final EdgeInsetsGeometry padding;
  final Widget body;
  const CustomScaffold({
    super.key,
    this.pageTitle,
    this.padding = const EdgeInsets.all(24.0),
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: pageTitle,
      ),
      body: SafeArea(
        child: Padding(
          padding: padding,
          child: body,
        ),
      ),
    );
  }
}
