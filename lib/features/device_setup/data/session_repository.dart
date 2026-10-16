import '../../../core/constants/app_strings.dart';
import '../../../core/session/worker_model.dart';

/// The error a session repository throws when the backend call fails.
class SessionException implements Exception {
  const SessionException(this.message);

  /// Text that can be shown to the worker.
  final String message;
}

/// Starts and ends the worker's shift session on the backend.
/// See the API contract: POST /api/session/start and POST /api/session/end.
abstract class SessionRepository {
  /// Starts the shift and returns the backend's `session_id`.
  Future<int> startSession({
    required WorkerModel worker,
    required String deviceId,
  });

  /// Ends the shift with the `session_id` from [startSession].
  Future<void> endSession({required int sessionId});
}

/// Fake backend used until the real one is running.
class MockSessionRepository implements SessionRepository {
  MockSessionRepository({this.delay = const Duration(milliseconds: 500)});

  /// How long the fake "network call" takes. Tests set this to zero.
  final Duration delay;

  /// Log in with this Employee ID to see the "could not start" failure.
  static const String failingEmployeeId = 'W000';

  @override
  Future<int> startSession({
    required WorkerModel worker,
    required String deviceId,
  }) async {
    await Future<void>.delayed(delay);

    if (worker.employeeId == failingEmployeeId) {
      throw const SessionException(AppStrings.couldNotStartShift);
    }

    // Shaped like the 201 response in the API contract.
    final fakeResponse = <String, dynamic>{
      'message': 'Session started successfully',
      'session_id': 1,
      'worker_name': worker.name,
      'zone': worker.location,
    };
    return fakeResponse['session_id'] as int;
  }

  @override
  Future<void> endSession({required int sessionId}) async {
    await Future<void>.delayed(delay);
  }
}
