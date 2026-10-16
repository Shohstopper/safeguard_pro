import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:safeguard_pro/core/constants/app_strings.dart';
import 'package:safeguard_pro/core/session/worker_model.dart';
import 'package:safeguard_pro/features/login/bloc/login_cubit.dart';
import 'package:safeguard_pro/features/login/bloc/login_state.dart';
import 'package:safeguard_pro/features/login/data/login_repository.dart';

/// A repository that always breaks in an unexpected way.
class _BrokenLoginRepository implements LoginRepository {
  @override
  Future<WorkerModel> login({
    required String name,
    required String employeeId,
    required String location,
  }) async {
    throw Exception('network down');
  }
}

void main() {
  const worker = WorkerModel(
    name: 'Ahmad Al-Rashidi',
    employeeId: 'SW-001',
    location: 'Site A — Zone 3',
  );

  LoginCubit buildCubit() =>
      LoginCubit(loginRepository: MockLoginRepository(delay: Duration.zero));

  test('starts in the initial state', () {
    expect(buildCubit().state, const LoginState());
  });

  blocTest<LoginCubit, LoginState>(
    'success: emits loading, then success with the worker',
    build: buildCubit,
    act: (cubit) => cubit.login(
      name: ' Ahmad Al-Rashidi ',
      employeeId: 'sw-001',
      location: 'Site A — Zone 3',
    ),
    expect: () => [
      const LoginState(status: LoginStatus.loading),
      const LoginState(status: LoginStatus.success, worker: worker),
    ],
  );

  blocTest<LoginCubit, LoginState>(
    'failure: emits loading, then failure when the employee is not found',
    build: buildCubit,
    act: (cubit) => cubit.login(
      name: 'Ahmad Al-Rashidi',
      employeeId: MockLoginRepository.failingEmployeeId,
      location: 'Site A — Zone 3',
    ),
    expect: () => [
      const LoginState(status: LoginStatus.loading),
      const LoginState(
        status: LoginStatus.failure,
        errorMessage: AppStrings.employeeNotFound,
      ),
    ],
  );

  blocTest<LoginCubit, LoginState>(
    'failure: shows a general message for unexpected errors',
    build: () => LoginCubit(loginRepository: _BrokenLoginRepository()),
    act: (cubit) => cubit.login(
      name: 'Ahmad Al-Rashidi',
      employeeId: 'SW-001',
      location: 'Site A — Zone 3',
    ),
    expect: () => [
      const LoginState(status: LoginStatus.loading),
      const LoginState(
        status: LoginStatus.failure,
        errorMessage: AppStrings.somethingWentWrong,
      ),
    ],
  );

  blocTest<LoginCubit, LoginState>(
    'empty fields: shows field errors and does not call the repository',
    build: buildCubit,
    act: (cubit) => cubit.login(name: '', employeeId: '', location: '  '),
    expect: () => [
      const LoginState(
        nameError: AppStrings.fieldRequired,
        employeeIdError: AppStrings.fieldRequired,
        locationError: AppStrings.fieldRequired,
      ),
    ],
  );

  blocTest<LoginCubit, LoginState>(
    'wrong employee ID format: shows the format error',
    build: buildCubit,
    act: (cubit) => cubit.login(
      name: 'Ahmad Al-Rashidi',
      employeeId: '12345',
      location: 'Site A — Zone 3',
    ),
    expect: () => [
      const LoginState(employeeIdError: AppStrings.employeeIdFormat),
    ],
  );
}
