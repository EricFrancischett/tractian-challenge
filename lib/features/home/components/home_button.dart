import 'package:flutter/material.dart';
import 'package:tractian_challenge/core/constants/colors_constants.dart';

class HomeButton extends StatelessWidget {
  final String title;
  final String routeToRedirect;
  final Object? arguments;
  const HomeButton({
    super.key,
    required this.routeToRedirect,
    required this.title,
    this.arguments,
  });

  @override
  Widget build(BuildContext context) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsConstants.lightBlue,
        foregroundColor: ColorsConstants.white,
        padding: const EdgeInsets.all(24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () {
        Navigator.pushNamed(
          context,
          routeToRedirect,
          arguments: arguments,
        );
      },
      child: Row(
        children: [
          const Icon(
            Icons.list_alt_rounded,
            size: 22,
            color: ColorsConstants.white,
          ),
          const SizedBox(width: 16),
          Text(
            title,
            style: const TextStyle(
              color: ColorsConstants.white,
            ),
          ),
        ],
      ),
    );
  }
}
