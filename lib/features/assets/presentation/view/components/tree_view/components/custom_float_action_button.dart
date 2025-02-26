import 'package:flutter/material.dart';
import 'package:tractian_challenge/core/constants/colors_constants.dart';

class CustomFloatActionButton extends StatelessWidget {
  final Function()? onTap;
  final bool showFloatingActionButton;
  const CustomFloatActionButton({
    super.key,
    this.onTap,
    required this.showFloatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    const double buttonSize = 50;
    return Padding(
      padding: const EdgeInsets.only(
        right: 16,
        bottom: 16,
      ),
      child: AnimatedCrossFade(
        duration: const Duration(milliseconds: 200),
        firstChild: const SizedBox(
          width: buttonSize,
          height: buttonSize,
        ),
        secondChild: InkWell(
          borderRadius: BorderRadius.circular(buttonSize/2),
          onTap: onTap,
          child: Container(
            decoration: const BoxDecoration(
                color: ColorsConstants.lightBlue, shape: BoxShape.circle),
            width: buttonSize,
            height: buttonSize,
            child: const Icon(
              Icons.arrow_upward_rounded,
              color: ColorsConstants.white,
              size: 28,
            ),
          ),
        ),
        crossFadeState: showFloatingActionButton
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
      ),
    );
  }
}
