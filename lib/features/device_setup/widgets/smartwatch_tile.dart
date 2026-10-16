import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../data/smartwatch_model.dart';

/// One smartwatch in the "AVAILABLE DEVICES" list. Turns blue with a check
/// mark when selected.
class SmartwatchTile extends StatelessWidget {
  const SmartwatchTile({
    super.key,
    required this.device,
    required this.isSelected,
    required this.onTap,
  });

  final SmartwatchModel device;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(AppRadius.tile);

    return Material(
      color: isSelected ? AppColors.selectedBackground : AppColors.card,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
        side: BorderSide(
          color: isSelected ? AppColors.primary : AppColors.cardBorder,
          width: AppSizes.borderInput,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.space14),
          child: Row(
            children: [
              Container(
                width: AppSizes.deviceIconBox,
                height: AppSizes.deviceIconBox,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.selectedIconBackground
                      : AppColors.subtleFill,
                  borderRadius: BorderRadius.circular(AppRadius.deviceIcon),
                ),
                child: Icon(
                  Icons.watch,
                  size: AppSizes.iconDevice,
                  color: isSelected ? AppColors.success : AppColors.primary,
                ),
              ),
              const SizedBox(width: AppSpacing.space13),
              Expanded(
                child: Text(device.name, style: AppTextStyles.tileTitle),
              ),
              _SelectionCircle(isSelected: isSelected),
            ],
          ),
        ),
      ),
    );
  }
}

/// The round check box on the right of the tile.
class _SelectionCircle extends StatelessWidget {
  const _SelectionCircle({required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizes.radio,
      height: AppSizes.radio,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? AppColors.primary : null,
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.radioBorder,
          width: AppSizes.borderInput,
        ),
      ),
      child: isSelected
          ? const Icon(
              Icons.check,
              size: AppSizes.iconTiny,
              color: AppColors.onPrimary,
            )
          : null,
    );
  }
}
