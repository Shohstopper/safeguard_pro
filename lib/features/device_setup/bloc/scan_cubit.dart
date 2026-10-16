import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/bluetooth_repository.dart';
import 'scan_state.dart';

/// The logic for the scan screen: asks the Bluetooth repository for nearby
/// smartwatches.
class ScanCubit extends Cubit<ScanState> {
  // Callers pass this as `bluetoothRepository:` (Dart drops the underscore).
  ScanCubit({required this._bluetoothRepository}) : super(const ScanState());

  final BluetoothRepository _bluetoothRepository;

  Future<void> scan() async {
    emit(const ScanState(status: ScanStatus.loading));

    try {
      final devices = await _bluetoothRepository.scanForSmartwatches();
      emit(ScanState(status: ScanStatus.success, devices: devices));
    } catch (_) {
      emit(const ScanState(status: ScanStatus.failure));
    }
  }
}
