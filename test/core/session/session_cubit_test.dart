import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:safeguard_pro/core/session/session_cubit.dart';
import 'package:safeguard_pro/core/session/session_state.dart';
import 'package:safeguard_pro/core/session/shift_model.dart';
import 'package:safeguard_pro/core/session/worker_model.dart';

void main() {
  const worker = WorkerModel(
    name: 'Ahmed Mohamed',
    employeeId: 'W001',
    location: 'Floor 10 - Zone A',
  );
  const shift = ShiftModel(
    sessionId: 1,
    deviceId: 'GW6-001',
    deviceName: 'Guardian Watch Pro',
  );

  test('starts with nobody signed in', () {
    expect(SessionCubit().state, const SessionState());
  });

  blocTest<SessionCubit, SessionState>(
    'signIn stores the worker',
    build: SessionCubit.new,
    act: (cubit) => cubit.signIn(worker),
    expect: () => [const SessionState(worker: worker)],
  );

  blocTest<SessionCubit, SessionState>(
    'startShift keeps the worker and adds the shift',
    build: SessionCubit.new,
    seed: () => const SessionState(worker: worker),
    act: (cubit) => cubit.startShift(shift),
    expect: () => [const SessionState(worker: worker, shift: shift)],
  );

  blocTest<SessionCubit, SessionState>(
    'signOut clears everything',
    build: SessionCubit.new,
    seed: () => const SessionState(worker: worker, shift: shift),
    act: (cubit) => cubit.signOut(),
    expect: () => [const SessionState()],
  );
}
