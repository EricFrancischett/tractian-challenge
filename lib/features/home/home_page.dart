import 'package:flutter/material.dart';
import 'package:tractian_challenge/core/adapters/svg_adapter.dart';
import 'package:tractian_challenge/core/constants/assets_constants.dart';
import 'package:tractian_challenge/core/constants/colors_constants.dart';
import 'package:tractian_challenge/core/enums/units_enum.dart';
import 'package:tractian_challenge/features/home/components/home_button.dart';
import 'package:tractian_challenge/features/home/components/home_header.dart';
import 'package:tractian_challenge/routes/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: ColorsConstants.homeGradient,
      ),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: HomeHeader(),
                ),
                SizedBox(
                  height: 40,
                ),
                HomeButton(
                  title: 'Jaguar Unit',
                  routeToRedirect: AppRoutes.assets,
                  arguments: {
                    AppRoutes.assetPageUnitKey: UnitsEnum.jaguar,
                  },
                ),
                SizedBox(height: 16),
                HomeButton(
                  title: 'Tobias Unit',
                  routeToRedirect: AppRoutes.assets,
                  arguments: {
                    AppRoutes.assetPageUnitKey: UnitsEnum.tobias,
                  },
                ),
                SizedBox(height: 16),
                HomeButton(
                  title: 'Apex Unit',
                  routeToRedirect: AppRoutes.assets,
                  arguments: {
                    AppRoutes.assetPageUnitKey: UnitsEnum.apex,
                  },
                ),
                Spacer(),
                SvgAdapter(
                  path: AssetsConstants.logo,
                  width: 200,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
