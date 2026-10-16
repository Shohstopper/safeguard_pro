import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

/// The glowing green circle with a check mark on the "You're connected"
/// screen.
class SuccessBadge extends StatelessWidget {
  const SuccessBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizes.successBadge,
      height: AppSizes.successBadge,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.successSoft,
        border: Border.all(color: AppColors.successRing),
        boxShadow: const [
          BoxShadow(color: AppColors.successGlow, blurRadius: 32),
        ],
      ),
      child: const Icon(
        Icons.check_rounded,
        size: AppSizes.iconSuccess,
        color: AppColors.success,
      ),
    );
  }
}
