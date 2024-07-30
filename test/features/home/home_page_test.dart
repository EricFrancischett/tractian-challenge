import 'package:flutter_test/flutter_test.dart';
import 'package:tractian_challenge/app_widget.dart';
import 'package:tractian_challenge/core/entities/asset/asset_entity.dart';
import 'package:tractian_challenge/core/entities/location/location_entity.dart';
import 'package:tractian_challenge/core/generics/resource.dart';
import 'package:tractian_challenge/features/assets/domain/usecases/get_assets_usecase.dart';
import 'package:tractian_challenge/features/assets/domain/usecases/get_locations_usecase.dart';
import 'package:tractian_challenge/features/assets/presentation/view/assets_page.dart';
import 'package:tractian_challenge/features/home/home_page.dart';
import '../../helpers/get_it_tester_helper.dart';

void main() {
  setUpAll(() async {
    await GetItTesterHelper.registerAllMocks();
    final getAssetsStub = GetAssetsUseCaseStub();
    final getLocationsStub = GetLocationsUseCaseStub();

    getAssetsStub.resultToUse = Resource.success(
      data: [
        AssetEntity(
          id: '1',
          name: 'Jaguar Unit',
        ),
        AssetEntity(
          id: '2',
          name: 'Tobias Unit',
        ),
        AssetEntity(
          id: '3',
          name: 'Apex Unit',
        ),
      ],
    );

    getLocationsStub.resultToUse = Resource.success(
      data: [
        LocationEntity(
          id: '1',
          name: 'Jaguar Unit',
        ),
        LocationEntity(
          id: '2',
          name: 'Tobias Unit',
        ),
        LocationEntity(
          id: '3',
          name: 'Apex Unit',
        ),
      ],
    );
  });

  group('end-to-end test', () {
    // Instance mock dependencies

    testWidgets('open app, tap on unit button and renders assets page',
        (tester) async {
      // Load app widget.
      await tester.pumpWidget(const AppWidget());

      // Wait for rendering.
      await tester.pumpAndSettle();

      // Searching for expecteds widgets.
      expect(find.byType(HomePage), findsOneWidget);
      expect(find.text('Jaguar Unit'), findsOneWidget);
      expect(find.text('Tobias Unit'), findsOneWidget);
      expect(find.text('Apex Unit'), findsOneWidget);

      // Finds the unit button to tap on.
      final unitButton = find.text("Jaguar Unit");

      // Emulate a tap on the unit button.
      await tester.tap(unitButton);

      // Wait for rendering.
      await tester.pumpAndSettle();

      // Verify the counter increments by 1.
      expect(find.byType(AssetsPage), findsOneWidget);
    });
  });
}

class GetAssetsUseCaseStub implements GetAssetsUsecase {
  Resource<List<AssetEntity>, Exception>? resultToUse;
  @override
  Future<Resource<List<AssetEntity>, Exception>> call(
      {required String assetFilePath}) async {
    return resultToUse!;
  }
}

class GetLocationsUseCaseStub implements GetLocationsUsecase {
  Resource<List<LocationEntity>, Exception>? resultToUse;
  @override
  Future<Resource<List<LocationEntity>, Exception>> call(
      {required String locationsFilePath}) async {
    return resultToUse!;
  }
}
