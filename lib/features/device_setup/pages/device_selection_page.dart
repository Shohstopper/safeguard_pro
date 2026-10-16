import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/router/app_router.dart';
import '../../../core/session/session_cubit.dart';
import '../../../core/session/shift_model.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/primary_button.dart';
import '../bloc/device_selection_cubit.dart';
import '../bloc/device_selection_state.dart';
import '../data/session_repository.dart';
import '../data/smartwatch_model.dart';
import '../widgets/setup_scaffold.dart';
import '../widgets/smartwatch_detected_intro.dart';
import '../widgets/smartwatch_tile.dart';

/// Step 2 of 3: pick the smartwatch and connect it (starts the shift).
class DeviceSelectionPage extends StatelessWidget {
  const DeviceSelectionPage({super.key, required this.devices});

  /// The smartwatches found on the scan screen.
  final List<SmartwatchModel> devices;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeviceSelectionCubit(
        sessionRepository: context.read<SessionRepository>(),
        devices: devices,
      ),
      child: const DeviceSelectionView(),
    );
  }
}

/// The "Choose a smartwatch" layout. Separate from [DeviceSelectionPage] so
/// tests can give it their own cubit.
class DeviceSelectionView extends StatelessWidget {
  const DeviceSelectionView({super.key});

  void _connect(BuildContext context) {
    final worker = context.read<SessionCubit>().state.worker;
    if (worker != null) {
      context.read<DeviceSelectionCubit>().connect(worker);
    }
  }

  // Navigation and snackbars happen here, not inside build().
  void _onStatusChanged(BuildContext context, DeviceSelectionState state) {
    final device = state.selected;
    if (state.status == ConnectStatus.success &&
        state.sessionId != null &&
        device != null) {
      context.read<SessionCubit>().startShift(
        ShiftModel(
          sessionId: state.sessionId!,
          deviceId: device.deviceId,
          deviceName: device.name,
        ),
      );
      context.go(AppRoutes.connected);
    } else if (state.status == ConnectStatus.failure) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(state.errorMessage ?? AppStrings.couldNotStartShift),
            action: SnackBarAction(
              label: AppStrings.tryAgain,
              onPressed: () => _connect(context),
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeviceSelectionCubit, DeviceSelectionState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: _onStatusChanged,
      child: BlocBuilder<DeviceSelectionCubit, DeviceSelectionState>(
        builder: (context, state) {
          final cubit = context.read<DeviceSelectionCubit>();

          return SetupScaffold(
            title: AppStrings.chooseSmartwatchTitle,
            subtitle: AppStrings.devicesFound(state.devices.length),
            body: ListView(
              padding: const EdgeInsets.only(top: AppSpacing.space30),
              children: [
                const SmartwatchDetectedIntro(),
                const SizedBox(height: AppSpacing.space25),
                const Text(
                  AppStrings.availableDevices,
                  style: AppTextStyles.sectionLabel,
                ),
                const SizedBox(height: AppSpacing.space10),
                for (final device in state.devices) ...[
                  SmartwatchTile(
                    device: device,
                    isSelected: device == state.selected,
                    onTap: () => cubit.selectDevice(device),
                  ),
                  const SizedBox(height: AppSpacing.space10),
                ],
              ],
            ),
            bottom: [
              const SizedBox(height: AppSpacing.space18),
              PrimaryButton(
                label: AppStrings.connectSmartwatch,
                loadingLabel: AppStrings.connecting,
                isLoading: state.isConnecting,
                onPressed: state.selected == null
                    ? null
                    : () => _connect(context),
              ),
            ],
          );
        },
      ),
    );
  }
}
