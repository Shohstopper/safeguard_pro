import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:safeguard_pro/core/widgets/primary_button.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

  testWidgets('shows the label and calls onPressed when tapped', (
    tester,
  ) async {
    var tapCount = 0;
    await tester.pumpWidget(
      wrap(PrimaryButton(label: 'Login', onPressed: () => tapCount++)),
    );

    expect(find.text('Login'), findsOneWidget);
    await tester.tap(find.byType(PrimaryButton));
    expect(tapCount, 1);
  });

  testWidgets('shows a spinner and ignores taps while loading', (tester) async {
    var tapCount = 0;
    await tester.pumpWidget(
      wrap(
        PrimaryButton(
          label: 'Login',
          loadingLabel: 'Signing in...',
          isLoading: true,
          onPressed: () => tapCount++,
        ),
      ),
    );

    expect(find.text('Signing in...'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.tap(find.byType(PrimaryButton));
    expect(tapCount, 0);
  });
}
