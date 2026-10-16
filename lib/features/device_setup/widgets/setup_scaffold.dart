import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import 'setup_header.dart';

/// The shared layout of the device setup screens: header at the top, [body]
/// filling the middle, and [bottom] (cards and buttons) at the bottom.
class SetupScaffold extends StatelessWidget {
  const SetupScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.body,
    required this.bottom,
    this.subtitleColor = AppColors.textMuted,
  });

  final String title;
  final String subtitle;
  final Color subtitleColor;
  final Widget body;
  final List<Widget> bottom;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.space28,
            horizontal: AppSpacing.space24,
          ),
          child: Column(
            children: [
              SetupHeader(
                title: title,
                subtitle: subtitle,
                subtitleColor: subtitleColor,
              ),
              Expanded(child: body),
              ...bottom,
            ],
          ),
        ),
      ),
    );
  }
}
