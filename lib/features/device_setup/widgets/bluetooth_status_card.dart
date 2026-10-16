import 'package:flutter/material.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

/// The card above the scan button: "Bluetooth required" (grey circle) or
/// "Bluetooth on" (green check).
class BluetoothStatusCard extends StatelessWidget {
  const BluetoothStatusCard({super.key, required this.isOn});

  final bool isOn;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.space14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.tile),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        children: [
          Container(
            width: AppSizes.statusIconBox,
            height: AppSizes.statusIconBox,
            decoration: BoxDecoration(
              color: isOn ? AppColors.successSoft : AppColors.subtleFillStrong,
              borderRadius: BorderRadius.circular(AppRadius.statusIcon),
            ),
            child: Icon(
              isOn ? Icons.check : Icons.circle_outlined,
              size: AppSizes.iconStatus,
              color: isOn ? AppColors.success : AppColors.textMuted,
            ),
          ),
          const SizedBox(width: AppSpacing.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isOn ? AppStrings.bluetoothOn : AppStrings.bluetoothRequired,
                  style: AppTextStyles.cardTitle,
                ),
                Text(
                  isOn
                      ? AppStrings.bluetoothOnMessage
                      : AppStrings.bluetoothRequiredMessage,
                  style: AppTextStyles.cardSubtitle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
