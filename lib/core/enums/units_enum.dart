import 'package:tractian_challenge/core/constants/units_assets_constants.dart';

enum UnitsEnum {
  apex(
    assets: UnitsAssetsConstants.apexAssets,
    locations: UnitsAssetsConstants.apexLocations,
    unitName: 'Apex Unit',
  ),
  jaguar(
    assets: UnitsAssetsConstants.jaguarAssets,
    locations: UnitsAssetsConstants.jaguarLocations,
    unitName: 'Jaguar Unit',
  ),
  tobias(
    assets: UnitsAssetsConstants.tobiasAssets,
    locations: UnitsAssetsConstants.tobiasLocations,
    unitName: 'Tobias Unit',
  );

  const UnitsEnum({
    required this.assets,
    required this.locations,
    required this.unitName,
  });

  final String assets;
  final String locations;
  final String unitName;
}
