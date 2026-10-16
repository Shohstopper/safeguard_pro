import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/router/app_router.dart';
import '../../../core/session/session_cubit.dart';
import '../../../core/session/shift_model.dart';
import '../../../core/session/worker_model.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../bloc/end_shift_cubit.dart';
import '../bloc/end_shift_state.dart';
import '../data/session_repository.dart';
import '../widgets/secondary_button.dart';
import '../widgets/setup_scaffold.dart';
import '../widgets/shift_summary_card.dart';
import '../widgets/success_badge.dart';

/// Step 3 of 3: "You're connected", with the shift summary and the button
/// to end the shift.
class ConnectedPage extends StatelessWidget {
  const ConnectedPage({super.key, required this.worker, required this.shift});

  final WorkerModel worker;
  final ShiftModel shift;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          EndShiftCubit(sessionRepository: context.read<SessionRepository>()),
      child: ConnectedView(worker: worker, shift: shift),
    );
  }
}

/// The "You're connected" layout. Separate from [ConnectedPage] so tests
/// can give it their own cubit.
class ConnectedView extends StatelessWidget {
  const ConnectedView({super.key, required this.worker, required this.shift});

  final WorkerModel worker;
  final ShiftModel shift;

  void _endShift(BuildContext context) {
    context.read<EndShiftCubit>().endShift(shift.sessionId);
  }

  // Navigation and snackbars happen here, not inside build().
  void _onStatusChanged(BuildContext context, EndShiftState state) {
    if (state.status == EndShiftStatus.success) {
      context.read<SessionCubit>().signOut();
      context.go(AppRoutes.login);
    } else if (state.status == EndShiftStatus.failure) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(state.errorMessage ?? AppStrings.couldNotEndShift),
            action: SnackBarAction(
              label: AppStrings.tryAgain,
              onPressed: () => _endShift(context),
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EndShiftCubit, EndShiftState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: _onStatusChanged,
      child: SetupScaffold(
        title: AppStrings.shiftProtectionActive,
        subtitle: AppStrings.connectedSuccessfully,
        subtitleColor: AppColors.success,
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.space24),
            child: Column(
              children: [
                const SuccessBadge(),
                const SizedBox(height: AppSpacing.space21),
                const Text(
                  AppStrings.youAreConnected,
                  style: AppTextStyles.successTitle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.space9),
                const Text(
                  AppStrings.youAreConnectedMessage,
                  style: AppTextStyles.bodyMuted,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.space24),
                ShiftSummaryCard(worker: worker, shift: shift),
              ],
            ),
          ),
        ),
        bottom: [
          BlocBuilder<EndShiftCubit, EndShiftState>(
            builder: (context, state) => SecondaryButton(
              label: AppStrings.endSession,
              loadingLabel: AppStrings.endingSession,
              isLoading: state.isEnding,
              onPressed: () => _endShift(context),
            ),
          ),
        ],
      ),
    );
  }
}
