import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tractian_challenge/app_widget.dart';
import 'package:tractian_challenge/core/generics/resource.dart';
import 'package:tractian_challenge/features/assets/presentation/view/assets_page.dart';
import 'package:tractian_challenge/features/assets/presentation/view/components/assets_text_field.dart';
import 'package:tractian_challenge/features/assets/presentation/view/components/empty_tree_view_widget.dart';
import 'package:tractian_challenge/features/assets/presentation/view/components/selectable_assets_button.dart';
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

    testWidgets(
        'When AssetsPage is opened, should renders all components correctly',
        (tester) async {
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
      expect(find.byType(Hero), findsOneWidget);
      expect(find.byType(AssetsTextField), findsOneWidget);
      expect(find.byType(SelectableButton), findsNWidgets(2));
      expect(find.byType(EmptyTreeViewWidget), findsOneWidget);
    });
  });
}
