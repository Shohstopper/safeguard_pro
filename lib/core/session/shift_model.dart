import 'package:equatable/equatable.dart';

/// An active shift: the backend session plus the smartwatch it is linked to.
/// It lives in core because the session cubit (app-wide) keeps it.
class ShiftModel extends Equatable {
  const ShiftModel({
    required this.sessionId,
    required this.deviceId,
    required this.deviceName,
  });

  /// The `session_id` the backend sent back from POST /api/session/start.
  /// Needed later to end the shift.
  final int sessionId;

  /// The smartwatch ID sent to the backend, like "GW6-001".
  final String deviceId;

  /// The smartwatch name shown on screen, like "Guardian Watch Pro".
  final String deviceName;

  @override
  List<Object> get props => [sessionId, deviceId, deviceName];
}
