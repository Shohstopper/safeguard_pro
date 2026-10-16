import 'package:equatable/equatable.dart';

/// A smartwatch found by the Bluetooth scan.
class SmartwatchModel extends Equatable {
  const SmartwatchModel({required this.deviceId, required this.name});

  /// The ID the backend knows the watch by (`device_id`), like "GW6-001".
  final String deviceId;

  /// The name shown on screen, like "Guardian Watch Pro".
  final String name;

  @override
  List<Object> get props => [deviceId, name];
}
