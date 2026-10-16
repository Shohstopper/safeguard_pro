import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

/// The dark outlined button ("End session & close shift").
///
/// While [isLoading] is true it shows a spinner with [loadingLabel] and
/// cannot be tapped.
class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.loadingLabel,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final String? loadingLabel;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(AppRadius.button);

    return Material(
      color: AppColors.subtleFill,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
        side: const BorderSide(color: AppColors.secondaryButtonBorder),
      ),
      child: InkWell(
        onTap: isLoading ? null : onPressed,
        borderRadius: borderRadius,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: AppSizes.buttonMinHeight,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading) ...[
                const SizedBox.square(
                  dimension: AppSizes.spinner,
                  child: CircularProgressIndicator(
                    strokeWidth: AppSizes.spinnerStroke,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(width: AppSpacing.space8),
              ],
              Flexible(
                child: Text(
                  isLoading ? (loadingLabel ?? label) : label,
                  style: AppTextStyles.secondaryButton,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
