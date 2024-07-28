import 'package:flutter/material.dart';
import 'package:tractian_challenge/constants/units_assets_constants.dart';
import 'package:tractian_challenge/features/assets/assets_page.dart';

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
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AssetsPage(
                      unitLocations: UnitsAssetsConstants.jaguarLocations,
                      unitAssets: UnitsAssetsConstants.jaguarAssets,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Tobias Unit'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AssetsPage(
                      unitLocations: UnitsAssetsConstants.tobiasLocations,
                      unitAssets: UnitsAssetsConstants.tobiasAssets,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Apex Unit'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AssetsPage(
                      unitLocations: UnitsAssetsConstants.apexLocations,
                      unitAssets: UnitsAssetsConstants.apexAssets,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Test Unit'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AssetsPage(
                      unitLocations: UnitsAssetsConstants.testLocations,
                      unitAssets: UnitsAssetsConstants.testAssets,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
