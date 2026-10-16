import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:safeguard_pro/features/device_setup/bloc/scan_cubit.dart';
import 'package:safeguard_pro/features/device_setup/bloc/scan_state.dart';
import 'package:safeguard_pro/features/device_setup/data/bluetooth_repository.dart';

void main() {
  ScanCubit buildCubit(MockScanOutcome outcome) => ScanCubit(
    bluetoothRepository: MockBluetoothRepository(
      outcome: outcome,
      delay: Duration.zero,
    ),
  );

  test('starts in the initial state with Bluetooth off', () {
    final state = buildCubit(MockScanOutcome.found).state;
    expect(state, const ScanState());
    expect(state.isBluetoothOn, isFalse);
  });

  blocTest<ScanCubit, ScanState>(
    'success: emits loading, then the found smartwatch',
    build: () => buildCubit(MockScanOutcome.found),
    act: (cubit) => cubit.scan(),
    expect: () => [
      const ScanState(status: ScanStatus.loading),
      const ScanState(
        status: ScanStatus.success,
        devices: [MockBluetoothRepository.guardianWatch],
      ),
    ],
  );

  blocTest<ScanCubit, ScanState>(
    'empty: emits loading, then success with no devices',
    build: () => buildCubit(MockScanOutcome.empty),
    act: (cubit) => cubit.scan(),
    expect: () => [
      const ScanState(status: ScanStatus.loading),
      const ScanState(status: ScanStatus.success),
    ],
    verify: (cubit) => expect(cubit.state.foundNothing, isTrue),
  );

  blocTest<ScanCubit, ScanState>(
    'failure: emits loading, then failure',
    build: () => buildCubit(MockScanOutcome.failure),
    act: (cubit) => cubit.scan(),
    expect: () => [
      const ScanState(status: ScanStatus.loading),
      const ScanState(status: ScanStatus.failure),
    ],
  );
}
