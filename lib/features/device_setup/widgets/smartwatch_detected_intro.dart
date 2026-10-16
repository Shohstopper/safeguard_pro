import 'package:flutter/material.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import 'bluetooth_badge.dart';

/// The small Bluetooth badge with "Smartwatch detected" and its message.
class SmartwatchDetectedIntro extends StatelessWidget {
  const SmartwatchDetectedIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        BluetoothBadge.small(),
        SizedBox(height: AppSpacing.space13),
        Text(
          AppStrings.smartwatchDetected,
          style: AppTextStyles.sectionTitle,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: AppSpacing.space7),
        Text(
          AppStrings.smartwatchDetectedMessage,
          style: AppTextStyles.bodyMuted,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
