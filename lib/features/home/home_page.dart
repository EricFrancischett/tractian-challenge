import 'package:flutter/material.dart';
import 'package:tractian_challenge/core/enums/units_enum.dart';
import 'package:tractian_challenge/core/widgets/custom_scaffold.dart';
import 'package:tractian_challenge/features/home/components/home_button.dart';
import 'package:tractian_challenge/routes/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          HomeButton(
            title: 'Jaguar Unit',
            routeToRedirect: AppRoutes.assets,
            arguments: {
              AppRoutes.assetPageUnitKey: UnitsEnum.jaguar,
            },
          ),
          SizedBox(height: 40),
          HomeButton(
            title: 'Tobias Unit',
            routeToRedirect: AppRoutes.assets,
            arguments: {
              AppRoutes.assetPageUnitKey: UnitsEnum.tobias,
            },
          ),
          SizedBox(height: 40),
          HomeButton(
            title: 'Apex Unit',
            routeToRedirect: AppRoutes.assets,
            arguments: {
              AppRoutes.assetPageUnitKey: UnitsEnum.apex,
            },
          ),
        ],
      ),
    );
  }
}
