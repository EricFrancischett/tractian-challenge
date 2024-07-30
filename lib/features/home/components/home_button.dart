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
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        foregroundColor: ColorsConstants.white,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: const BoxDecoration(
                  color: ColorsConstants.lightBlue,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                child: const Icon(
                  Icons.factory_rounded,
                  size: 22,
                  color: ColorsConstants.darkBlue,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  color: ColorsConstants.white,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
            color: ColorsConstants.white.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}
