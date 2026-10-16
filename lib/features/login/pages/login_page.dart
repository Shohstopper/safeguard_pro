import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/router/app_router.dart';
import '../../../core/session/session_cubit.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../bloc/login_cubit.dart';
import '../bloc/login_state.dart';
import '../widgets/login_form_card.dart';
import '../widgets/login_header.dart';
import '../widgets/secured_connection_badge.dart';

/// The login screen ("Welcome Back").
///
/// It creates the LoginCubit here, because only this screen uses it.
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: const LoginView(),
    );
  }
}

/// The login screen layout. Separate from [LoginPage] so tests can give it
/// their own cubit.
class LoginView extends StatelessWidget {
  const LoginView({super.key});

  // Runs once each time the status changes. Navigation belongs here, not
  // inside build().
  void _onStatusChanged(BuildContext context, LoginState state) {
    if (state.status == LoginStatus.success && state.worker != null) {
      context.read<SessionCubit>().signIn(state.worker!);
      context.go(AppRoutes.scan);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: _onStatusChanged,
      child: Scaffold(
        body: SafeArea(
          // Scrolls when the keyboard is open or the phone is small, and
          // still pushes the footer to the bottom on tall phones.
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppSpacing.space24,
                  horizontal: AppSpacing.space20,
                ),
                sliver: SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: const [
                      LoginHeader(),
                      SizedBox(height: AppSpacing.space24),
                      LoginFormCard(),
                      SizedBox(height: AppSpacing.space20),
                      SecuredConnectionBadge(),
                      SizedBox(height: AppSpacing.space20),
                      Spacer(),
                      Text(
                        AppStrings.safetyFooter,
                        style: AppTextStyles.footer,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
