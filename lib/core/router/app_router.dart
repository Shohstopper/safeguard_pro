import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/device_setup/data/smartwatch_model.dart';
import '../../features/device_setup/pages/connected_page.dart';
import '../../features/device_setup/pages/device_selection_page.dart';
import '../../features/device_setup/pages/scan_page.dart';
import '../../features/login/pages/login_page.dart';
import '../session/session_cubit.dart';

/// The path of every screen in the app.
abstract final class AppRoutes {
  static const String login = '/login';
  static const String scan = '/scan';
  static const String devices = '/devices';
  static const String connected = '/connected';
}

/// All app routes in one place. The app starts on the login screen.
///
/// Each `redirect` is a simple guard: if a screen is opened without the data
/// it needs (for example nobody is signed in), go somewhere safe instead.
final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.login,
  routes: [
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: AppRoutes.scan,
      redirect: (context, state) =>
          context.read<SessionCubit>().state.worker == null
          ? AppRoutes.login
          : null,
      builder: (context, state) => const ScanPage(),
    ),
    GoRoute(
      path: AppRoutes.devices,
      // The scan screen sends the found watches as `extra`.
      redirect: (context, state) {
        if (context.read<SessionCubit>().state.worker == null) {
          return AppRoutes.login;
        }
        return state.extra is List<SmartwatchModel> ? null : AppRoutes.scan;
      },
      builder: (context, state) =>
          DeviceSelectionPage(devices: state.extra! as List<SmartwatchModel>),
    ),
    GoRoute(
      path: AppRoutes.connected,
      redirect: (context, state) =>
          context.read<SessionCubit>().state.shift == null
          ? AppRoutes.login
          : null,
      builder: (context, state) {
        final session = context.read<SessionCubit>().state;
        return ConnectedPage(worker: session.worker!, shift: session.shift!);
      },
    ),
  ],
);
