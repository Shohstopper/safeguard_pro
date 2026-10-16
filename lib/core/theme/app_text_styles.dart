import 'package:flutter/material.dart';

import 'app_colors.dart';

/// All text styles used in the app, taken from the Figma design.
///
/// Letter spacing in Figma is written in "em". Here it is converted to
/// pixels: 0.1em on an 11px font is 1.1px.
abstract final class AppTextStyles {
  static const String fontFamily = 'Inter';

  static const TextStyle pageTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w700,
    height: 1.2,
    color: AppColors.textPrimary,
  );

  static const TextStyle pageSubtitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    color: AppColors.textMuted,
  );

  static const TextStyle sectionLabel = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.1,
    color: AppColors.textMuted,
  );

  static const TextStyle fieldLabel = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.48,
    color: AppColors.textMuted,
  );

  static const TextStyle input = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    color: AppColors.textPrimary,
  );

  static const TextStyle inputSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    color: AppColors.textPrimary,
  );

  static const TextStyle inputError = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    color: AppColors.danger,
  );

  static const TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.15,
    color: AppColors.onPrimary,
  );

  static const TextStyle dividerLabel = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    letterSpacing: 0.88,
    color: AppColors.textDim,
  );

  static const TextStyle successBadge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.success,
  );

  static const TextStyle footer = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    letterSpacing: 0.36,
    color: AppColors.textDim,
  );

  static const TextStyle snackBar = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    color: AppColors.textPrimary,
  );
}
