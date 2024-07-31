import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgAdapter extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final Color? color;

  const SvgAdapter({
    super.key,
    required this.path,
    this.width,
    this.height,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      width: width,
      height: height,
      colorFilter: color != null
          ? ColorFilter.mode(
              color!,
              BlendMode.srcIn,
            )
          : null,
    );
  }
}
