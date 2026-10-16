import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:safeguard_pro/core/session/session_cubit.dart';
import 'package:safeguard_pro/core/session/worker_model.dart';

void main() {
  const worker = WorkerModel(
    name: 'Ahmad Al-Rashidi',
    employeeId: 'SW-001',
    location: 'Site A — Zone 3',
  );

  test('starts with nobody signed in', () {
    expect(SessionCubit().state, isNull);
  });

  blocTest<SessionCubit, WorkerModel?>(
    'signIn stores the worker',
    build: SessionCubit.new,
    act: (cubit) => cubit.signIn(worker),
    expect: () => [worker],
  );

  blocTest<SessionCubit, WorkerModel?>(
    'signOut clears the worker',
    build: SessionCubit.new,
    seed: () => worker,
    act: (cubit) => cubit.signOut(),
    expect: () => [null],
  );
}
