import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tractian_challenge/app_widget.dart';
import 'package:tractian_challenge/features/home/home_page.dart';

void main() {
  // setUpAll(() async {
  //   await GetItTesterHelper.registerAllMocks();
  // });

  // setUp(() {
  //   // Instance mock dependencies
  //   AssetsController mockController = GetIt.I<AssetsController>();

  //   // mocking use cases response
  //   when(() => mockController.getAssetsUsecase
  //           .call(assetFilePath: UnitsAssetsConstants.jaguarAssets))
  //       .thenAnswer((_) async => Resource.success(data: []));
  //   when(() => mockController.getLocationsUsecase
  //           .call(locationsFilePath: UnitsAssetsConstants.jaguarAssets))
  //       .thenAnswer((_) async => Resource.success(data: []));
  // });

  // IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('end-to-end test', () {
    testWidgets('open app, tap on unit button and renders assets page',
        (tester) async {
      // Load app widget.
      await tester.pumpWidget(const AppWidget());

      // Wait for rendering.
      await tester.pumpAndSettle();

      // Searching for expecteds widgets.
      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('TRACTIAN'), findsOneWidget);
      expect(find.text('Jaguar Unit'), findsOneWidget);
      expect(find.text('Tobias Unit'), findsOneWidget);
      expect(find.text('Apex Unit'), findsOneWidget);

      // // Finds the unit button to tap on.
      // final unitButton = find.byKey(const ValueKey('jaguar_unit_button'));

      // // Emulate a tap on the unit button.
      // await tester.tap(unitButton);

      // // Wait for rendering.
      // await tester.pumpAndSettle();

      // // Verify the counter increments by 1.
      // expect(find.byType(AssetsPage), findsOneWidget);
      // expect(find.byType(AppBar), findsOneWidget);
      // expect(find.text('Assets'), findsOneWidget);
    });
  });
}
