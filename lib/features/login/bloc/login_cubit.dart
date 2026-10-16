import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/utils/validators.dart';
import '../data/login_repository.dart';
import 'login_state.dart';

/// The logic for the login screen: checks the fields, then asks the
/// repository to sign the worker in.
class LoginCubit extends Cubit<LoginState> {
  // Callers pass this as `loginRepository:` (Dart drops the underscore).
  LoginCubit({required this._loginRepository}) : super(const LoginState());

  final LoginRepository _loginRepository;

  Future<void> login({
    required String name,
    required String employeeId,
    required String location,
  }) async {
    // Step 1: check the fields. If any is wrong, show the errors and stop.
    final nameError = Validators.requiredField(name);
    final employeeIdError = Validators.employeeId(employeeId);
    final locationError = Validators.requiredField(location);

    if (nameError != null || employeeIdError != null || locationError != null) {
      emit(
        LoginState(
          nameError: nameError,
          employeeIdError: employeeIdError,
          locationError: locationError,
        ),
      );
      return;
    }

    // Step 2: fields are fine, so show the spinner and call the repository.
    emit(const LoginState(status: LoginStatus.loading));

    try {
      final worker = await _loginRepository.login(
        name: name.trim(),
        employeeId: employeeId.trim().toUpperCase(),
        location: location.trim(),
      );
      emit(LoginState(status: LoginStatus.success, worker: worker));
    } on LoginException catch (error) {
      emit(
        LoginState(status: LoginStatus.failure, errorMessage: error.message),
      );
    } catch (_) {
      // Any other unexpected problem gets a general message.
      emit(
        const LoginState(
          status: LoginStatus.failure,
          errorMessage: AppStrings.somethingWentWrong,
        ),
      );
    }
  }
}
