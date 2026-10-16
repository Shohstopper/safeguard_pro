import '../../../core/constants/app_strings.dart';
import '../../../core/session/worker_model.dart';

/// The error a login repository throws when signing in fails.
class LoginException implements Exception {
  const LoginException(this.message);

  final String message;
}

/// Signs a worker in. The cubit only knows about this abstract class, so we
/// can swap the fake version for the real one in app.dart later.
abstract class LoginRepository {
  Future<WorkerModel> login({
    required String name,
    required String employeeId,
    required String location,
  });
}

/// Fake login used until the backend is ready.
///
/// Note: the real login endpoint is not known yet. When it is, add an
/// ApiLoginRepository that calls it and switch to it in app.dart.
class MockLoginRepository implements LoginRepository {
  MockLoginRepository({this.delay = const Duration(milliseconds: 500)});

  /// How long the fake "network call" takes. Tests set this to zero.
  final Duration delay;

  /// Use this Employee ID on the login screen to see the failure state.
  static const String failingEmployeeId = 'SW-000';

  @override
  Future<WorkerModel> login({
    required String name,
    required String employeeId,
    required String location,
  }) async {
    await Future<void>.delayed(delay);

    if (employeeId == failingEmployeeId) {
      throw const LoginException(AppStrings.employeeNotFound);
    }

    // Shaped like the JSON we expect the real API to send back.
    final fakeResponse = <String, dynamic>{
      'name': name,
      'employee_id': employeeId,
      'location': location,
    };
    return WorkerModel.fromJson(fakeResponse);
  }
}
