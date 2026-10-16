import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/constants/app_strings.dart';
import 'core/router/app_router.dart';
import 'core/session/session_cubit.dart';
import 'core/theme/app_theme.dart';
import 'features/login/data/login_repository.dart';

/// The root of the app. Repositories and app-wide cubits are created here,
/// once, so the whole app can use them.
class SafeGuardApp extends StatelessWidget {
  const SafeGuardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        // To use the real backend later, change MockLoginRepository() to
        // ApiLoginRepository() on this one line.
        RepositoryProvider<LoginRepository>(
          create: (context) => MockLoginRepository(),
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
