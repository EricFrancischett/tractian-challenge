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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: HomeHeader(),
                ),
                const SizedBox(
                  height: 40,
                ),
                HomeButton(
                  title: UnitsEnum.jaguar.unitName,
                  routeToRedirect: AppRoutes.assets,
                  arguments: const {
                    AppRoutes.assetPageUnitKey: UnitsEnum.jaguar,
                  },
                ),
                const SizedBox(height: 16),
                HomeButton(
                  title: UnitsEnum.tobias.unitName,
                  routeToRedirect: AppRoutes.assets,
                  arguments: const {
                    AppRoutes.assetPageUnitKey: UnitsEnum.tobias,
                  },
                ),
                const SizedBox(height: 16),
                HomeButton(
                  title: UnitsEnum.apex.unitName,
                  routeToRedirect: AppRoutes.assets,
                  arguments: const {
                    AppRoutes.assetPageUnitKey: UnitsEnum.apex,
                  },
                ),
                const Spacer(),
                const Hero(
                  tag: 'logo',
                  child: SvgAdapter(
                    path: AssetsConstants.logo,
                    width: 200,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
