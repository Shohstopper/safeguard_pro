import 'package:equatable/equatable.dart';

import '../data/smartwatch_model.dart';

/// The 4 steps of the scan screen.
enum ScanStatus { initial, loading, success, failure }

/// Everything the scan screen needs to draw itself.
class ScanState extends Equatable {
  const ScanState({this.status = ScanStatus.initial, this.devices = const []});

  final ScanStatus status;

  /// The smartwatches found. Only filled when [status] is success.
  final List<SmartwatchModel> devices;

  /// Bluetooth is turned on as soon as the worker starts the first scan.
  bool get isBluetoothOn => status != ScanStatus.initial;

  /// The scan worked, but no smartwatch was nearby (the "empty" case).
  bool get foundNothing => status == ScanStatus.success && devices.isEmpty;

  @override
  List<Object> get props => [status, devices];
}
