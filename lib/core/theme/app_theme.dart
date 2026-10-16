import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_text_styles.dart';

/// The app's dark theme. Text fields and snackbars get their look from here,
/// so pages do not need to style them one by one.
abstract final class AppTheme {
  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: AppTextStyles.fontFamily,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
        error: AppColors.danger,
      ),
      inputDecorationTheme: _inputDecorationTheme,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.primary,
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppColors.card,
        contentTextStyle: AppTextStyles.snackBar,
        behavior: SnackBarBehavior.floating,
        actionTextColor: AppColors.primary,
      ),
    );
  }

  static final InputDecorationTheme _inputDecorationTheme =
      InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputBackground,
        isDense: true,
        hintStyle: AppTextStyles.input.copyWith(color: AppColors.textMuted),
        errorStyle: AppTextStyles.inputError,
        enabledBorder: _border(AppColors.inputBorder),
        disabledBorder: _border(AppColors.inputBorder),
        focusedBorder: _border(AppColors.primary),
        errorBorder: _border(AppColors.danger),
        focusedErrorBorder: _border(AppColors.danger),
      );

  static OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.input),
      borderSide: BorderSide(color: color, width: AppSizes.borderInput),
    );
  }
}
