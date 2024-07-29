import 'package:flutter/material.dart';
import 'package:tractian_challenge/core/adapters/svg_adapter.dart';
import 'package:tractian_challenge/core/constants/assets_constants.dart';
import 'package:tractian_challenge/core/constants/colors_constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  const CustomAppBar({
    super.key,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(
        color: ColorsConstants.white,
      ),
      backgroundColor: ColorsConstants.darkBlue,
      title: _buildTitle(title: title),
    );
  }

  Widget _buildTitle({String? title}) {
    if (title != null) {
      return Text(
        title,
        style: const TextStyle(
          color: ColorsConstants.white,
        ),
      );
    }
    return const SvgAdapter(
      path: AssetsConstants.logo,
      color: ColorsConstants.white,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
