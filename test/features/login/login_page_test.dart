import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:safeguard_pro/core/constants/app_strings.dart';
import 'package:safeguard_pro/core/session/session_cubit.dart';
import 'package:safeguard_pro/core/theme/app_theme.dart';
import 'package:safeguard_pro/features/login/data/login_repository.dart';
import 'package:safeguard_pro/features/login/pages/login_page.dart';

void main() {
  Widget buildLoginPage() {
    return RepositoryProvider<LoginRepository>(
      create: (context) => MockLoginRepository(delay: Duration.zero),
      child: BlocProvider(
        create: (context) => SessionCubit(),
        child: MaterialApp(theme: AppTheme.dark, home: const LoginPage()),
      ),
    );
  }

  testWidgets('shows the design text', (tester) async {
    await tester.pumpWidget(buildLoginPage());

    expect(find.text(AppStrings.welcomeBack), findsOneWidget);
    expect(find.text(AppStrings.workerIdentity), findsOneWidget);
    expect(find.text(AppStrings.login), findsOneWidget);
    expect(find.text(AppStrings.sslEncrypted), findsOneWidget);
  });

  testWidgets('tapping Login with empty fields shows Required errors', (
    tester,
  ) async {
    await tester.pumpWidget(buildLoginPage());

    await tester.tap(find.text(AppStrings.login));
    await tester.pump();

    expect(find.text(AppStrings.fieldRequired), findsNWidgets(3));
  });

  testWidgets('a failed login shows the error in a snackbar', (tester) async {
    await tester.pumpWidget(buildLoginPage());

    final fields = find.byType(TextField);
    await tester.enterText(fields.at(0), 'Ahmad Al-Rashidi');
    await tester.enterText(fields.at(1), MockLoginRepository.failingEmployeeId);
    await tester.enterText(fields.at(2), 'Site A — Zone 3');
    await tester.tap(find.text(AppStrings.login));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.employeeNotFound), findsOneWidget);
  });
}
