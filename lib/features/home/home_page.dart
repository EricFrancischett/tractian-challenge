import 'package:flutter/material.dart';
import 'package:tractian_challenge/core/enums/units_enum.dart';
import 'package:tractian_challenge/routes/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TRACTIAN'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              child: const Text('Jaguar Unit'),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.assets,
                  arguments: {
                    AppRoutes.assetPageUnitKey: UnitsEnum.jaguar,
                  },
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Tobias Unit'),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.assets,
                  arguments: {
                    AppRoutes.assetPageUnitKey: UnitsEnum.tobias,
                  },
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Apex Unit'),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.assets,
                  arguments: {
                    AppRoutes.assetPageUnitKey: UnitsEnum.apex,
                  },
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Test Unit'),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.assets,
                  arguments: {
                    AppRoutes.assetPageUnitKey: UnitsEnum.test,
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
