import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/login/pages/login_page.dart';
import '../constants/app_strings.dart';
import '../theme/app_text_styles.dart';

/// The path of every screen in the app.
abstract final class AppRoutes {
  static const String login = '/login';
  static const String scan = '/scan';
}

/// All app routes in one place. The app starts on the login screen.
final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.login,
  routes: [
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginPage(),
    ),
    // TODO(device-setup): replace this placeholder with ScanPage when the
    // device setup feature (Step C) is built.
    GoRoute(
      path: AppRoutes.scan,
      builder: (context, state) => const _NextStepPlaceholderPage(),
    ),
  ],
);

/// Temporary screen shown after login until the device setup screens exist.
class _NextStepPlaceholderPage extends StatelessWidget {
  const _NextStepPlaceholderPage();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          AppStrings.deviceSetupComingNext,
          style: AppTextStyles.pageSubtitle,
        ),
      ),
    );
  }
}
