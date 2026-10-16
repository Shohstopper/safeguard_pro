import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:safeguard_pro/core/constants/app_strings.dart';
import 'package:safeguard_pro/core/session/worker_model.dart';
import 'package:safeguard_pro/features/device_setup/bloc/device_selection_cubit.dart';
import 'package:safeguard_pro/features/device_setup/bloc/device_selection_state.dart';
import 'package:safeguard_pro/features/device_setup/data/session_repository.dart';
import 'package:safeguard_pro/features/device_setup/data/smartwatch_model.dart';

/// A backend that always breaks in an unexpected way.
class _BrokenSessionRepository implements SessionRepository {
  @override
  Future<int> startSession({
    required WorkerModel worker,
    required String deviceId,
  }) async => throw Exception('network down');

  @override
  Future<void> endSession({required int sessionId}) async {}
}

void main() {
  const watch = SmartwatchModel(
    deviceId: 'GW6-001',
    name: 'Guardian Watch Pro',
  );
  const otherWatch = SmartwatchModel(deviceId: 'GW6-002', name: 'Spare Watch');
  const devices = [watch, otherWatch];
  const worker = WorkerModel(
    name: 'Ahmed Mohamed',
    employeeId: 'W001',
    location: 'Floor 10 - Zone A',
  );

  DeviceSelectionCubit buildCubit({
    List<SmartwatchModel> foundDevices = devices,
    SessionRepository? repository,
  }) => DeviceSelectionCubit(
    sessionRepository:
        repository ?? MockSessionRepository(delay: Duration.zero),
    devices: foundDevices,
  );

  test('picks the first smartwatch at the start', () {
    expect(buildCubit().state.selected, watch);
  });

  test('picks nothing when the list is empty', () {
    expect(buildCubit(foundDevices: const []).state.selected, isNull);
  });

  blocTest<DeviceSelectionCubit, DeviceSelectionState>(
    'selectDevice changes the picked smartwatch',
    build: buildCubit,
    act: (cubit) => cubit.selectDevice(otherWatch),
    expect: () => [
      const DeviceSelectionState(devices: devices, selected: otherWatch),
    ],
  );

  blocTest<DeviceSelectionCubit, DeviceSelectionState>(
    'success: emits loading, then success with the session ID',
    build: buildCubit,
    act: (cubit) => cubit.connect(worker),
    expect: () => [
      const DeviceSelectionState(
        devices: devices,
        selected: watch,
        status: ConnectStatus.loading,
      ),
      const DeviceSelectionState(
        devices: devices,
        selected: watch,
        status: ConnectStatus.success,
        sessionId: 1,
      ),
    ],
  );

  blocTest<DeviceSelectionCubit, DeviceSelectionState>(
    'failure: the backend refuses, so the error message is shown',
    build: buildCubit,
    act: (cubit) => cubit.connect(
      const WorkerModel(
        name: 'Ahmed Mohamed',
        employeeId: MockSessionRepository.failingEmployeeId,
        location: 'Floor 10 - Zone A',
      ),
    ),
    expect: () => [
      const DeviceSelectionState(
        devices: devices,
        selected: watch,
        status: ConnectStatus.loading,
      ),
      const DeviceSelectionState(
        devices: devices,
        selected: watch,
        status: ConnectStatus.failure,
        errorMessage: AppStrings.couldNotStartShift,
      ),
    ],
  );

  blocTest<DeviceSelectionCubit, DeviceSelectionState>(
    'failure: unexpected errors get a general message',
    build: () => buildCubit(repository: _BrokenSessionRepository()),
    act: (cubit) => cubit.connect(worker),
    skip: 1,
    expect: () => [
      const DeviceSelectionState(
        devices: devices,
        selected: watch,
        status: ConnectStatus.failure,
        errorMessage: AppStrings.somethingWentWrong,
      ),
    ],
  );

  blocTest<DeviceSelectionCubit, DeviceSelectionState>(
    'empty: connect does nothing when no smartwatch was found',
    build: () => buildCubit(foundDevices: const []),
    act: (cubit) => cubit.connect(worker),
    expect: () => <DeviceSelectionState>[],
  );
}
