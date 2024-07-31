import 'package:flutter/material.dart';
import 'package:tractian_challenge/core/adapters/svg_adapter.dart';
import 'package:tractian_challenge/core/constants/assets_constants.dart';
import 'package:tractian_challenge/core/constants/colors_constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(
        color: ColorsConstants.darkBlue,
      ),
      surfaceTintColor: ColorsConstants.transparent,
      backgroundColor: ColorsConstants.white,
      centerTitle: true,
      title: _buildTitle(title: title),
      toolbarHeight: 80,
    );
  }

  Widget _buildTitle({required String title}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Hero(
          tag: 'logo',
          child: SvgAdapter(
            path: AssetsConstants.logo,
            color: ColorsConstants.darkBlue.withOpacity(0.2),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: const BoxDecoration(
                color: ColorsConstants.lightBlue,
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child: const Icon(
                Icons.factory_rounded,
                size: 12,
                color: ColorsConstants.white,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: ColorsConstants.lightBlue,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
