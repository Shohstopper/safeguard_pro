import 'package:dio/dio.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/session/worker_model.dart';
import 'session_repository.dart';

/// The real backend, following the API contract.
///
/// To use it, change MockSessionRepository() to ApiSessionRepository() in
/// app.dart, and make sure the backend is running.
class ApiSessionRepository implements SessionRepository {
  ApiSessionRepository({Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: ApiConstants.baseUrl,
              connectTimeout: ApiConstants.timeout,
              receiveTimeout: ApiConstants.timeout,
            ),
          );

  final Dio _dio;

  @override
  Future<int> startSession({
    required WorkerModel worker,
    required String deviceId,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiConstants.sessionStartPath,
        data: {
          'worker_name': worker.name,
          'worker_id': worker.employeeId,
          'zone': worker.location,
          'device_id': deviceId,
        },
      );
      return response.data!['session_id'] as int;
    } on DioException catch (error) {
      throw SessionException(_messageFrom(error));
    }
  }

  @override
  Future<void> endSession({required int sessionId}) async {
    try {
      await _dio.post<Map<String, dynamic>>(
        ApiConstants.sessionEndPath,
        data: {'session_id': sessionId},
      );
    } on DioException catch (error) {
      throw SessionException(_messageFrom(error));
    }
  }

  /// Turns a failed request into text for the worker.
  ///
  /// The backend sends errors as {"error": "..."}. If there is no response
  /// at all, the server could not be reached.
  String _messageFrom(DioException error) {
    final body = error.response?.data;
    if (body is Map && body['error'] is String) {
      return body['error'] as String;
    }
    if (error.response == null) {
      return AppStrings.cannotReachServer;
    }
    return AppStrings.somethingWentWrong;
  }
}
