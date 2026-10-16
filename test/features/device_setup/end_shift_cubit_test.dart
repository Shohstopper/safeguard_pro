import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:safeguard_pro/core/constants/app_strings.dart';
import 'package:safeguard_pro/core/session/worker_model.dart';
import 'package:safeguard_pro/features/device_setup/bloc/end_shift_cubit.dart';
import 'package:safeguard_pro/features/device_setup/bloc/end_shift_state.dart';
import 'package:safeguard_pro/features/device_setup/data/session_repository.dart';

/// A backend whose end-session call fails with [error].
class _FailingSessionRepository implements SessionRepository {
  _FailingSessionRepository(this.error);

  final Object error;

  @override
  Future<int> startSession({
    required WorkerModel worker,
    required String deviceId,
  }) async => 1;

  @override
  Future<void> endSession({required int sessionId}) async => throw error;
}

void main() {
  test('starts in the initial state', () {
    final cubit = EndShiftCubit(sessionRepository: MockSessionRepository());
    expect(cubit.state, const EndShiftState());
  });

  blocTest<EndShiftCubit, EndShiftState>(
    'success: emits loading, then success',
    build: () => EndShiftCubit(
      sessionRepository: MockSessionRepository(delay: Duration.zero),
    ),
    act: (cubit) => cubit.endShift(1),
    expect: () => [
      const EndShiftState(status: EndShiftStatus.loading),
      const EndShiftState(status: EndShiftStatus.success),
    ],
  );

  blocTest<EndShiftCubit, EndShiftState>(
    'failure: shows the backend message (e.g. no active session)',
    build: () => EndShiftCubit(
      sessionRepository: _FailingSessionRepository(
        const SessionException('No active session found'),
      ),
    ),
    act: (cubit) => cubit.endShift(1),
    expect: () => [
      const EndShiftState(status: EndShiftStatus.loading),
      const EndShiftState(
        status: EndShiftStatus.failure,
        errorMessage: 'No active session found',
      ),
    ],
  );

  blocTest<EndShiftCubit, EndShiftState>(
    'failure: unexpected errors get a general message',
    build: () => EndShiftCubit(
      sessionRepository: _FailingSessionRepository(Exception('boom')),
    ),
    act: (cubit) => cubit.endShift(1),
    expect: () => [
      const EndShiftState(status: EndShiftStatus.loading),
      const EndShiftState(
        status: EndShiftStatus.failure,
        errorMessage: AppStrings.couldNotEndShift,
      ),
    ],
  );
}
