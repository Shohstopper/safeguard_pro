import 'package:equatable/equatable.dart';

import '../data/smartwatch_model.dart';

/// The 4 steps of connecting the chosen smartwatch.
enum ConnectStatus { initial, loading, success, failure }

/// Everything the "Choose a smartwatch" screen needs to draw itself.
class DeviceSelectionState extends Equatable {
  const DeviceSelectionState({
    required this.devices,
    this.selected,
    this.status = ConnectStatus.initial,
    this.sessionId,
    this.errorMessage,
  });

  /// The smartwatches found by the scan.
  final List<SmartwatchModel> devices;

  /// The smartwatch the worker picked. Null means none is picked yet.
  final SmartwatchModel? selected;

  final ConnectStatus status;

  /// The backend's `session_id`. Only set when [status] is success.
  final int? sessionId;

  /// Why connecting failed. Only set when [status] is failure.
  final String? errorMessage;

  bool get isConnecting => status == ConnectStatus.loading;

  @override
  List<Object?> get props => [
    devices,
    selected,
    status,
    sessionId,
    errorMessage,
  ];
}
