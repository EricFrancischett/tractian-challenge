import 'package:flutter/material.dart';
import 'package:tractian_challenge/core/constants/colors_constants.dart';

class SelectableButton extends StatelessWidget {
  final SelectableButtonVariant variant;
  final void Function(bool?)? onChanged;
  final bool isSelected;
  const SelectableButton({
    super.key,
    required this.variant,
    this.onChanged,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        onChanged?.call(!isSelected);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 26,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color:
              isSelected ? ColorsConstants.darkBlue : ColorsConstants.lightGray,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              variant.icon,
              size: 16,
              color: variant.iconColor,
            ),
            const SizedBox(width: 8),
            Text(
              variant.title,
              style: TextStyle(
                color: isSelected
                    ? ColorsConstants.white
                    : ColorsConstants.darkBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum SelectableButtonVariant {
  energy(
      title: 'Sensor de energia',
      icon: Icons.offline_bolt_rounded,
      iconColor: ColorsConstants.lightGreen),
  alert(
      title: 'Estado crítico',
      icon: Icons.error,
      iconColor: ColorsConstants.lightRed),
  ;

  const SelectableButtonVariant({
    required this.title,
    required this.icon,
    required this.iconColor,
  });
  final String title;
  final IconData icon;
  final Color iconColor;
}
