import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/primary_button.dart';
import '../bloc/login_cubit.dart';
import '../bloc/login_state.dart';
import 'login_text_field.dart';
import 'section_label.dart';

/// The "WORKER IDENTITY" card with the three fields and the Login button.
///
/// It is a StatefulWidget only to hold the text controllers (tiny local
/// state). Everything else comes from the LoginCubit.
class LoginFormCard extends StatefulWidget {
  const LoginFormCard({super.key});

  @override
  State<LoginFormCard> createState() => _LoginFormCardState();
}

class _LoginFormCardState extends State<LoginFormCard> {
  final _nameController = TextEditingController();
  final _employeeIdController = TextEditingController();
  final _locationController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _employeeIdController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _submit() {
    // Close the keyboard, then hand the typed values to the cubit.
    FocusScope.of(context).unfocus();
    context.read<LoginCubit>().login(
      name: _nameController.text,
      employeeId: _employeeIdController.text,
      location: _locationController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return AppCard(
          child: Column(
            children: [
              const SectionLabel(text: AppStrings.workerIdentity),
              const SizedBox(height: AppSpacing.space16),
              LoginTextField(
                label: AppStrings.employeeNameLabel,
                hint: AppStrings.employeeNameHint,
                icon: Icons.person_outline,
                controller: _nameController,
                errorText: state.nameError,
                enabled: !state.isLoading,
                textCapitalization: TextCapitalization.words,
              ),
              const SizedBox(height: AppSpacing.space14),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: LoginTextField(
                      label: AppStrings.employeeIdLabel,
                      hint: AppStrings.employeeIdHint,
                      icon: Icons.badge_outlined,
                      controller: _employeeIdController,
                      errorText: state.employeeIdError,
                      enabled: !state.isLoading,
                      isCompact: true,
                      textCapitalization: TextCapitalization.characters,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.space10),
                  Expanded(
                    child: LoginTextField(
                      label: AppStrings.locationLabel,
                      hint: AppStrings.locationHint,
                      icon: Icons.location_on_outlined,
                      controller: _locationController,
                      errorText: state.locationError,
                      enabled: !state.isLoading,
                      isCompact: true,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _submit(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.space14),
              PrimaryButton(
                label: AppStrings.login,
                loadingLabel: AppStrings.signingIn,
                icon: Icons.login,
                isLoading: state.isLoading,
                onPressed: _submit,
              ),
            ],
          ),
        );
      },
    );
  }
}
