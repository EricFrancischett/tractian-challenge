import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tractian_challenge/app_widget.dart';
import 'package:tractian_challenge/core/generics/resource.dart';
import 'package:tractian_challenge/features/assets/presentation/view/assets_page.dart';
import 'package:tractian_challenge/features/home/presentation/view/components/home_button.dart';
import 'package:tractian_challenge/features/home/presentation/view/components/home_header.dart';
import 'package:tractian_challenge/features/home/presentation/view/home_page.dart';
import '../../../../helpers/get_it_tester_helper.dart';

void main() {
  setUpAll(() async {
    await GetItTesterHelper.registerAllMocks();
    final getAssetsStub = GetAssetsUseCaseStub();
    final getLocationsStub = GetLocationsUseCaseStub();

    getAssetsStub.resultToUse = Resource.success(
      data: [],
    );

    getLocationsStub.resultToUse = Resource.success(
      data: [],
    );
  });

  group('end-to-end test', () {
    // Instance mock dependencies

    testWidgets('When app is opened, home page should renders correctly', (tester) async {
      // Load app widget.
      await tester.pumpWidget(const AppWidget());

      // Wait for rendering.
      await tester.pumpAndSettle();

      // Searching for expecteds widgets.
      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(HomeHeader), findsOneWidget);
      expect(find.byType(HomeButton), findsNWidgets(3));
      expect(find.text('Jaguar Unit'), findsOneWidget);
      expect(find.text('Tobias Unit'), findsOneWidget);
      expect(find.text('Apex Unit'), findsOneWidget);
      expect(find.byType(Hero), findsOneWidget);
    });


    testWidgets('When unit button is tapped, should renders AssetsPage correctly', (tester) async {
      // Load app widget.
      await tester.pumpWidget(const AppWidget());

      // Wait for rendering.
      await tester.pumpAndSettle();

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
