import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

/// The big blue gradient button from the design.
///
/// While [isLoading] is true it shows a spinner with [loadingLabel] and
/// cannot be tapped. It is also disabled when [onPressed] is null.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.loadingLabel,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final String? loadingLabel;

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null && !isLoading;
    final borderRadius = BorderRadius.circular(AppRadius.button);

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        gradient: isEnabled ? AppColors.primaryGradient : null,
        color: isEnabled ? null : AppColors.primaryDisabled,
        boxShadow: isEnabled
            ? const [
                BoxShadow(
                  color: AppColors.primaryGlow,
                  blurRadius: 20,
                  offset: Offset(0, 4),
                ),
              ]
            : null,
      ),
      // Material + InkWell give the tap ripple on top of the gradient.
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: isEnabled ? onPressed : null,
          borderRadius: borderRadius,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.space16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isLoading)
                  const _ButtonSpinner()
                else if (icon != null)
                  Icon(
                    icon,
                    size: AppSizes.iconLarge,
                    color: AppColors.onPrimary,
                  ),
                if (isLoading || icon != null)
                  const SizedBox(width: AppSpacing.space8),
                Flexible(
                  child: Text(
                    isLoading ? (loadingLabel ?? label) : label,
                    style: AppTextStyles.button,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ButtonSpinner extends StatelessWidget {
  const _ButtonSpinner();

  @override
  Widget build(BuildContext context) {
    return const SizedBox.square(
      dimension: AppSizes.spinner,
      child: CircularProgressIndicator(
        strokeWidth: AppSizes.spinnerStroke,
        color: AppColors.onPrimary,
        backgroundColor: AppColors.spinnerTrack,
      ),
    );
  }
}
