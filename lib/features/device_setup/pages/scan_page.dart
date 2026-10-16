import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/primary_button.dart';
import '../bloc/scan_cubit.dart';
import '../bloc/scan_state.dart';
import '../data/bluetooth_repository.dart';
import '../widgets/bluetooth_status_card.dart';
import '../widgets/scan_status_view.dart';
import '../widgets/setup_scaffold.dart';

/// Step 1 of 3: turn on Bluetooth and scan for smartwatches.
class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ScanCubit(bluetoothRepository: context.read<BluetoothRepository>()),
      child: const ScanView(),
    );
  }
}

/// The scan screen layout. Separate from [ScanPage] so tests can give it
/// their own cubit.
class ScanView extends StatelessWidget {
  const ScanView({super.key});

  @override
  Widget build(BuildContext context) {
    // When watches are found, go to step 2 and hand over the list.
    return BlocListener<ScanCubit, ScanState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == ScanStatus.success && state.devices.isNotEmpty) {
          context.go(AppRoutes.devices, extra: state.devices);
        }
      },
      child: BlocBuilder<ScanCubit, ScanState>(
        builder: (context, state) {
          // Keep the spinner on while we move to the next screen.
          final isBusy =
              state.status == ScanStatus.loading ||
              (state.status == ScanStatus.success && state.devices.isNotEmpty);

          return SetupScaffold(
            title: AppStrings.deviceSetupTitle,
            subtitle: AppStrings.deviceSetupStep,
            body: ScanStatusView(state: state),
            bottom: [
              BluetoothStatusCard(isOn: state.isBluetoothOn),
              const SizedBox(height: AppSpacing.space16),
              PrimaryButton(
                label: _buttonLabel(state),
                loadingLabel: AppStrings.scanningNearbyDevices,
                isLoading: isBusy,
                onPressed: () => context.read<ScanCubit>().scan(),
              ),
            ],
          );
        },
      ),
    );
  }

  String _buttonLabel(ScanState state) {
    if (state.status == ScanStatus.failure) return AppStrings.tryAgain;
    if (state.foundNothing) return AppStrings.scanAgain;
    return AppStrings.turnOnBluetoothAndScan;
  }
}
