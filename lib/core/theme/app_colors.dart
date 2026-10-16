import 'package:flutter/material.dart';

/// All colors used in the app, taken from the Figma design.
///
/// Colors with transparency are written as 0xAARRGGBB, where AA is the
/// opacity (for example 0x24 is about 14%).
abstract final class AppColors {
  // Backgrounds
  static const Color background = Color(0xFF070F1C);
  static const Color surface = Color(0xFF0D1B2E);
  static const Color card = Color(0xFF112238);
  static const Color cardBorder = Color(0x242D7EF8);
  static const Color inputBackground = Color(0xFF0A1726);
  static const Color inputBorder = Color(0x1AFFFFFF);

  // Brand blue
  static const Color primary = Color(0xFF2D7EF8);
  static const Color primaryLight = Color(0xFF3B8EFF);
  static const Color primaryDark = Color(0xFF1A5FCC);
  static const Color primaryGlow = Color(0x732D7EF8);
  static const Color primaryDisabled = Color(0x802D7EF8);

  // Text
  static const Color textPrimary = Color(0xFFEEF2FF);
  static const Color textMuted = Color(0xFF7A93BB);
  static const Color textDim = Color(0xFF4A6280);
  static const Color iconMuted = Color(0x807A93BB);
  static const Color onPrimary = Colors.white;
  static const Color spinnerTrack = Color(0x4DFFFFFF);

  // Blue highlights (Bluetooth badge, selected smartwatch)
  static const Color primarySoft = Color(0x1F2D7EF8);
  static const Color primarySoftBorder = Color(0x402D7EF8);
  static const Color primaryActive = Color(0x2E2D7EF8);
  static const Color primaryActiveBorder = Color(0x6B3B8EFF);
  static const Color primaryActiveGlow = Color(0x332D7EF8);
  static const Color selectedBackground = Color(0x242D7EF8);
  static const Color selectedIconBackground = Color(0x382D7EF8);
  static const Color selectedRing = Color(0x1A2D7EF8);

  // Neutral overlays on the dark background
  static const Color subtleFill = Color(0x0BFFFFFF);
  static const Color subtleFillStrong = Color(0x0FFFFFFF);
  static const Color radioBorder = Color(0x38FFFFFF);
  static const Color secondaryButtonBorder = Color(0x29FFFFFF);

  // Status
  static const Color success = Color(0xFF22C55E);
  static const Color successBackground = Color(0x1222C55E);
  static const Color successBorder = Color(0x2622C55E);
  static const Color successSoft = Color(0x2422C55E);
  static const Color successRing = Color(0x4722C55E);
  static const Color successGlow = Color(0x2122C55E);
  static const Color danger = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);

  // Lines and shadows
  static const Color divider = Color(0x0FFFFFFF);
  static const Color cardShadow = Color(0x4D000000);

  /// Gradient used on the main blue buttons (135 degrees in the design).
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryLight, primaryDark],
  );
}
