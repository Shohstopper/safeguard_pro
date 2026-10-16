import 'package:flutter/material.dart';

import '../constants/app_assets.dart';
import '../constants/app_strings.dart';

/// The SafeGuard Pro logo image at a given height (width follows the image).
class AppLogo extends StatelessWidget {
  const AppLogo({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssets.logo,
      height: height,
      fit: BoxFit.contain,
      semanticLabel: AppStrings.appName,
    );
  }
}
