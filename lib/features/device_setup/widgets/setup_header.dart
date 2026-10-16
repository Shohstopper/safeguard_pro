import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_logo.dart';

/// The small logo box with a title and a subtitle, at the top of each
/// device setup screen (for example "Device setup" / "Step 1 of 3").
class SetupHeader extends StatelessWidget {
  const SetupHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.subtitleColor = AppColors.textMuted,
  });

  final String title;
  final String subtitle;
  final Color subtitleColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: AppSizes.headerLogoBoxWidth,
          height: AppSizes.headerLogoBoxHeight,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(AppRadius.logoBox),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: const AppLogo(height: AppSizes.headerLogoHeight),
        ),
        const SizedBox(width: AppSpacing.space12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.headerTitle),
              Text(
                subtitle,
                style: AppTextStyles.headerSubtitle.copyWith(
                  color: subtitleColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
