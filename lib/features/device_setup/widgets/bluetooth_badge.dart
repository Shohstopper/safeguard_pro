import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

/// The rounded square with a Bluetooth icon.
///
/// The large one (scan screen) lights up blue when [isActive]. The small one
/// ("Smartwatch detected") is always blue.
class BluetoothBadge extends StatelessWidget {
  const BluetoothBadge.large({super.key, required this.isActive})
    : isLarge = true;

  const BluetoothBadge.small({super.key}) : isLarge = false, isActive = true;

  final bool isLarge;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final size = isLarge
        ? AppSizes.bluetoothBadgeLarge
        : AppSizes.bluetoothBadgeSmall;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(
          isLarge
              ? AppRadius.bluetoothBadgeLarge
              : AppRadius.bluetoothBadgeSmall,
        ),
        border: Border.all(color: _borderColor),
        boxShadow: isLarge && isActive
            ? const [
                BoxShadow(color: AppColors.primaryActiveGlow, blurRadius: 38),
              ]
            : null,
      ),
      child: Icon(
        Icons.bluetooth,
        size: isLarge
            ? AppSizes.iconBluetoothLarge
            : AppSizes.iconBluetoothSmall,
        color: isActive ? AppColors.primary : AppColors.textMuted,
      ),
    );
  }

  Color get _backgroundColor {
    if (!isLarge) return AppColors.primarySoft;
    return isActive ? AppColors.primaryActive : AppColors.subtleFill;
  }

  Color get _borderColor {
    if (!isLarge) return AppColors.primarySoftBorder;
    return isActive ? AppColors.primaryActiveBorder : AppColors.cardBorder;
  }
}
