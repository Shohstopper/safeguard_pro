import 'package:equatable/equatable.dart';

import '../../../core/session/worker_model.dart';

/// The login screen is either waiting for input, or done (all fields valid).
///
/// There is no loading or failure step: the backend has no login endpoint,
/// so signing in only checks the fields on the phone.
enum LoginStatus { initial, success }

/// Everything the login screen needs to draw itself.
class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.initial,
    this.worker,
    this.nameError,
    this.employeeIdError,
    this.locationError,
  });

  final LoginStatus status;

  /// The worker built from the form. Only set when [status] is success.
  final WorkerModel? worker;

  // Error text shown under each field. Null means the field is fine.
  final String? nameError;
  final String? employeeIdError;
  final String? locationError;

  @override
  List<Object?> get props => [
    status,
    worker,
    nameError,
    employeeIdError,
    locationError,
  ];
}
