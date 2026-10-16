import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/session/worker_model.dart';
import '../../../core/utils/validators.dart';
import 'login_state.dart';

/// The logic for the login screen: checks the three fields and, if they are
/// all filled in, builds the worker.
///
/// It does not call the backend. The API contract has no login endpoint;
/// the shift session is started later, when the smartwatch is connected.
class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  void login({
    required String name,
    required String employeeId,
    required String location,
  }) {
    final nameError = Validators.requiredField(name);
    final employeeIdError = Validators.requiredField(employeeId);
    final locationError = Validators.requiredField(location);

    // If any field is wrong, show the errors and stop.
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

    final worker = WorkerModel(
      name: name.trim(),
      employeeId: employeeId.trim(),
      location: location.trim(),
    );
    emit(LoginState(status: LoginStatus.success, worker: worker));
  }
}
