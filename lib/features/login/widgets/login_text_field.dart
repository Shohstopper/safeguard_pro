import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

/// A label (like "EMPLOYEE NAME") with a text field and an icon inside it.
///
/// Set [isCompact] for the two smaller side-by-side fields in the design.
class LoginTextField extends StatelessWidget {
  const LoginTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    required this.controller,
    this.errorText,
    this.isCompact = false,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.none,
    this.onSubmitted,
  });

  final String label;
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final String? errorText;
  final bool isCompact;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    final textStyle = isCompact
        ? AppTextStyles.inputSmall
        : AppTextStyles.input;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.fieldLabel),
        const SizedBox(height: AppSpacing.space8),
        TextField(
          controller: controller,
          style: textStyle,
          textInputAction: textInputAction,
          textCapitalization: textCapitalization,
          onSubmitted: onSubmitted,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: textStyle.copyWith(color: AppColors.textMuted),
            errorText: errorText,
            contentPadding: EdgeInsets.symmetric(
              vertical: isCompact ? AppSpacing.space13 : AppSpacing.space14,
              horizontal: isCompact ? AppSpacing.space12 : AppSpacing.space14,
            ),
            prefixIcon: Icon(
              icon,
              color: AppColors.iconMuted,
              size: isCompact ? AppSizes.iconMedium : AppSizes.iconLarge,
            ),
            prefixIconConstraints: BoxConstraints(
              minWidth: isCompact
                  ? AppSizes.inputIconAreaNarrow
                  : AppSizes.inputIconAreaWide,
            ),
          ),
        ),
      ],
    );
  }
}
