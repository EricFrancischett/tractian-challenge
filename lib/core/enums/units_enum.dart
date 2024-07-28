import 'package:tractian_challenge/core/constants/units_assets_constants.dart';

enum UnitsEnum {
  apex(
    assets: UnitsAssetsConstants.apexAssets,
    locations: UnitsAssetsConstants.apexLocations,
  ),
  jaguar(
    assets: UnitsAssetsConstants.jaguarAssets,
    locations: UnitsAssetsConstants.jaguarLocations,
  ),
  tobias(
    assets: UnitsAssetsConstants.tobiasAssets,
    locations: UnitsAssetsConstants.tobiasLocations,
  ),
  test(
    assets: UnitsAssetsConstants.testAssets,
    locations: UnitsAssetsConstants.testLocations,
  );

  const UnitsEnum({
    required this.assets,
    required this.locations,
  });

  final String assets;
  final String locations;
}
