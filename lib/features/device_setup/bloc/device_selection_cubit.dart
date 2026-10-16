import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/session/worker_model.dart';
import '../data/session_repository.dart';
import '../data/smartwatch_model.dart';
import 'device_selection_state.dart';

/// The logic for the "Choose a smartwatch" screen: remembers which watch is
/// picked, then starts the shift session on the backend.
class DeviceSelectionCubit extends Cubit<DeviceSelectionState> {
  DeviceSelectionCubit({
    required this._sessionRepository,
    required List<SmartwatchModel> devices,
  }) : super(
         // The design shows the first (company-issued) watch already picked.
         DeviceSelectionState(
           devices: devices,
           selected: devices.isEmpty ? null : devices.first,
         ),
       );

  final SessionRepository _sessionRepository;

  void selectDevice(SmartwatchModel device) {
    if (state.isConnecting) return;
    emit(DeviceSelectionState(devices: state.devices, selected: device));
  }

  /// Starts the shift for [worker] with the picked smartwatch.
  Future<void> connect(WorkerModel worker) async {
    final device = state.selected;
    if (device == null || state.isConnecting) return;

    emit(
      DeviceSelectionState(
        devices: state.devices,
        selected: device,
        status: ConnectStatus.loading,
      ),
    );

    try {
      final sessionId = await _sessionRepository.startSession(
        worker: worker,
        deviceId: device.deviceId,
      );
      emit(
        DeviceSelectionState(
          devices: state.devices,
          selected: device,
          status: ConnectStatus.success,
          sessionId: sessionId,
        ),
      );
    } on SessionException catch (error) {
      _emitFailure(device, error.message);
    } catch (_) {
      _emitFailure(device, AppStrings.somethingWentWrong);
    }
  }

  void _emitFailure(SmartwatchModel device, String message) {
    emit(
      DeviceSelectionState(
        devices: state.devices,
        selected: device,
        status: ConnectStatus.failure,
        errorMessage: message,
      ),
    );
  }
}
