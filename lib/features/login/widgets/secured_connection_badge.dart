import 'package:flutter/material.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

/// The "SECURED CONNECTION" divider and the green "256-bit SSL Encrypted"
/// box under the login card.
class SecuredConnectionBadge extends StatelessWidget {
  const SecuredConnectionBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Expanded(child: Divider(color: AppColors.divider, height: 1)),
            SizedBox(width: AppSpacing.space12),
            Text(
              AppStrings.securedConnection,
              style: AppTextStyles.dividerLabel,
            ),
            SizedBox(width: AppSpacing.space12),
            Expanded(child: Divider(color: AppColors.divider, height: 1)),
          ],
        ),
        const SizedBox(height: AppSpacing.space20),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.space10,
            horizontal: AppSpacing.space16,
          ),
          decoration: BoxDecoration(
            color: AppColors.successBackground,
            borderRadius: BorderRadius.circular(AppRadius.badge),
            border: Border.all(color: AppColors.successBorder),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.verified_user,
                size: AppSizes.iconSmall,
                color: AppColors.success,
              ),
              SizedBox(width: AppSpacing.space8),
              Text(AppStrings.sslEncrypted, style: AppTextStyles.successBadge),
            ],
          ),
        ),
      ],
    );
  }
}
