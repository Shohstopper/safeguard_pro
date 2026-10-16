import 'package:flutter/material.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/session/shift_model.dart';
import '../../../core/session/worker_model.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

/// The card on the "You're connected" screen listing the worker, their ID,
/// location and the linked smartwatch.
class ShiftSummaryCard extends StatelessWidget {
  const ShiftSummaryCard({
    super.key,
    required this.worker,
    required this.shift,
  });

  final WorkerModel worker;
  final ShiftModel shift;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.summaryCard),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        children: [
          _SummaryRow(label: AppStrings.workerLabel, value: worker.name),
          const Divider(color: AppColors.cardBorder, height: 1),
          _SummaryRow(
            label: AppStrings.employeeIdLabel,
            value: worker.employeeId,
          ),
          const Divider(color: AppColors.cardBorder, height: 1),
          _SummaryRow(label: AppStrings.locationLabel, value: worker.location),
          const Divider(color: AppColors.cardBorder, height: 1),
          _SummaryRow(
            label: AppStrings.smartwatchLabel,
            value: shift.deviceName,
            valueColor: AppColors.success,
          ),
        ],
      ),
    );
  }
}

/// One "LABEL ......... value" row.
class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.valueColor = AppColors.textPrimary,
  });

  final String label;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.space14,
        horizontal: AppSpacing.space16,
      ),
      child: Row(
        children: [
          Text(label, style: AppTextStyles.summaryLabel),
          const SizedBox(width: AppSpacing.space12),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.summaryValue.copyWith(color: valueColor),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
