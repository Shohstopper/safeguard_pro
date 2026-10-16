import 'package:flutter/material.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_logo.dart';

/// The logo, "Welcome Back" title and subtitle at the top of the login screen.
class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(
          width: AppSizes.loginLogoBoxWidth,
          height: AppSizes.loginLogoBoxHeight,
          child: Center(child: AppLogo(height: AppSizes.loginLogoHeight)),
        ),
        SizedBox(height: AppSpacing.space12),
        Text(
          AppStrings.welcomeBack,
          style: AppTextStyles.pageTitle,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: AppSpacing.space4),
        Text(
          AppStrings.signInSubtitle,
          style: AppTextStyles.pageSubtitle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
