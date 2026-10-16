import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/constants/app_strings.dart';
import 'core/router/app_router.dart';
import 'core/session/session_cubit.dart';
import 'core/theme/app_theme.dart';
import 'features/device_setup/data/bluetooth_repository.dart';
import 'features/device_setup/data/session_repository.dart';

/// The root of the app. Repositories and app-wide cubits are created here,
/// once, so the whole app can use them.
class SafeGuardApp extends StatelessWidget {
  const SafeGuardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        // Fake Bluetooth scan. To try the other screens, pass
        // outcome: MockScanOutcome.empty or MockScanOutcome.failure.
        RepositoryProvider<BluetoothRepository>(
          create: (context) => MockBluetoothRepository(),
        ),
        // Fake backend. To use the real backend, change this to
        // ApiSessionRepository() (from api_session_repository.dart).
        RepositoryProvider<SessionRepository>(
          create: (context) => MockSessionRepository(),
        ),
      ],
      child: BlocProvider(
        create: (context) => SessionCubit(),
        child: MaterialApp.router(
          title: AppStrings.appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.dark,
          routerConfig: appRouter,
          // Light status bar icons, because the app background is dark.
          builder: (context, child) => AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: child!,
          ),
        ),
      ),
    );
  }
}
