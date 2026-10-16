import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

/// A small blue bar followed by a title, like "WORKER IDENTITY".
class SectionLabel extends StatelessWidget {
  const SectionLabel({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: AppSizes.sectionMarkerWidth,
          height: AppSizes.sectionMarkerHeight,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(AppRadius.sectionMarker),
          ),
        ),
        const SizedBox(width: AppSpacing.space8),
        Flexible(child: Text(text, style: AppTextStyles.sectionLabel)),
      ],
    );
  }
}
