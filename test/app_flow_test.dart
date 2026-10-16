import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:safeguard_pro/app.dart';
import 'package:safeguard_pro/core/constants/app_strings.dart';

/// Walks through the whole app with the fake data:
/// login -> scan -> choose smartwatch -> connected -> end shift -> login.
void main() {
  testWidgets('full shift flow works from login to end of shift', (
    tester,
  ) async {
    // A normal phone size, so every button is on screen.
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.75;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const SafeGuardApp());
    await tester.pumpAndSettle();

    // 1. Login
    final fields = find.byType(TextField);
    await tester.enterText(fields.at(0), 'Ahmed Mohamed');
    await tester.enterText(fields.at(1), 'W001');
    await tester.enterText(fields.at(2), 'Floor 10 - Zone A');
    await tester.tap(find.text(AppStrings.login));
    await tester.pumpAndSettle();

    // 2. Scan (the fake scan takes 1 second)
    expect(find.text(AppStrings.readyToScan), findsOneWidget);
    await tester.tap(find.text(AppStrings.turnOnBluetoothAndScan));
    await tester.pump();
    expect(find.text(AppStrings.lookingForSmartwatches), findsOneWidget);
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    // 3. Choose a smartwatch (the fake backend takes 500 ms)
    expect(find.text(AppStrings.smartwatchDetected), findsOneWidget);
    expect(find.text('Guardian Watch Pro'), findsOneWidget);
    await tester.tap(find.text(AppStrings.connectSmartwatch));
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();

    // 4. Connected: the summary shows the worker and the watch
    expect(find.text(AppStrings.youAreConnected), findsOneWidget);
    expect(find.text('Ahmed Mohamed'), findsOneWidget);
    expect(find.text('W001'), findsOneWidget);
    expect(find.text('Floor 10 - Zone A'), findsOneWidget);
    expect(find.text('Guardian Watch Pro'), findsOneWidget);

    // 5. End the shift and land back on login
    await tester.tap(find.text(AppStrings.endSession));
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.welcomeBack), findsOneWidget);
  });
}
