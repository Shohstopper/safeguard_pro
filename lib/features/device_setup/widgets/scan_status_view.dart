import 'package:flutter/material.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../bloc/scan_state.dart';
import 'bluetooth_badge.dart';

/// The middle of the scan screen: the Bluetooth badge, a title and a short
/// message that change with the scan state.
class ScanStatusView extends StatelessWidget {
  const ScanStatusView({super.key, required this.state});

  final ScanState state;

  @override
  Widget build(BuildContext context) {
    final (title, message) = _texts;

    // Scrolls only if the phone is very small, so nothing overflows.
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: AppSpacing.space38),
        child: Column(
          children: [
            BluetoothBadge.large(isActive: state.isBluetoothOn),
            const SizedBox(height: AppSpacing.space26),
            Text(
              title,
              style: AppTextStyles.scanTitle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.space10),
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppSizes.messageMaxWidth,
              ),
              child: Text(
                message,
                style: AppTextStyles.bodyMuted,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// The title and message for the current state.
  (String, String) get _texts {
    if (state.status == ScanStatus.failure) {
      return (AppStrings.scanFailed, AppStrings.bluetoothScanError);
    }
    if (state.foundNothing) {
      return (
        AppStrings.noSmartwatchesFound,
        AppStrings.noSmartwatchesFoundMessage,
      );
    }
    if (state.isBluetoothOn) {
      return (
        AppStrings.lookingForSmartwatches,
        AppStrings.lookingForSmartwatchesMessage,
      );
    }
    return (AppStrings.readyToScan, AppStrings.readyToScanMessage);
  }
}
