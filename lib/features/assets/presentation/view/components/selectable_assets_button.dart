import 'package:flutter/material.dart';
import 'package:tractian_challenge/core/constants/colors_constants.dart';

class SelectableButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function(bool?)? onChanged;
  final bool isSelected;
  const SelectableButton({
    super.key,
    required this.title,
    required this.icon,
    this.onChanged,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        style: _setButtonStyle(),
        onPressed: () {
          onChanged?.call(!isSelected);
        },
        child: Row(
          children: [
            Icon(
              icon,
              size: 12,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: isSelected? ColorsConstants.white : ColorsConstants.darkGray,
              ),
            ),
          ],
        ),
      ),
    );
  }

  ButtonStyle _setButtonStyle() {
    if (isSelected) {
      return ElevatedButton.styleFrom(
        textStyle: const TextStyle(
          color: ColorsConstants.white,
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        foregroundColor: ColorsConstants.white,
        iconColor: ColorsConstants.white,
        padding: const EdgeInsets.all(24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      );
    }
    return ElevatedButton.styleFrom(
      textStyle: const TextStyle(
        color: ColorsConstants.darkGray,
      ),
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      foregroundColor: ColorsConstants.darkGray,
      iconColor: ColorsConstants.white,
      padding: const EdgeInsets.all(24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(
          color: ColorsConstants.darkGray,
          width: 2,
        ),
      ),
    );
  }
}
