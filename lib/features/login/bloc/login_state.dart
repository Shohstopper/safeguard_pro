import 'package:equatable/equatable.dart';

import '../../../core/session/worker_model.dart';

/// The 4 steps the login screen can be in.
enum LoginStatus { initial, loading, success, failure }

/// Everything the login screen needs to draw itself.
class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.initial,
    this.worker,
    this.errorMessage,
    this.nameError,
    this.employeeIdError,
    this.locationError,
  });

  final LoginStatus status;

  /// The signed-in worker. Only set when [status] is success.
  final WorkerModel? worker;

  /// Why login failed. Only set when [status] is failure.
  final String? errorMessage;

  // Error text shown under each field. Null means the field is fine.
  final String? nameError;
  final String? employeeIdError;
  final String? locationError;

  bool get isLoading => status == LoginStatus.loading;

  @override
  List<Object?> get props => [
    status,
    worker,
    errorMessage,
    nameError,
    employeeIdError,
    locationError,
  ];
}
