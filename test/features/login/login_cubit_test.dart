import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:safeguard_pro/core/constants/app_strings.dart';
import 'package:safeguard_pro/core/session/worker_model.dart';
import 'package:safeguard_pro/features/login/bloc/login_cubit.dart';
import 'package:safeguard_pro/features/login/bloc/login_state.dart';

void main() {
  test('starts in the initial state', () {
    expect(LoginCubit().state, const LoginState());
  });

  blocTest<LoginCubit, LoginState>(
    'success: valid fields give a worker (with spaces trimmed)',
    build: LoginCubit.new,
    act: (cubit) => cubit.login(
      name: ' Ahmed Mohamed ',
      employeeId: ' W001 ',
      location: 'Floor 10 - Zone A',
    ),
    expect: () => [
      const LoginState(
        status: LoginStatus.success,
        worker: WorkerModel(
          name: 'Ahmed Mohamed',
          employeeId: 'W001',
          location: 'Floor 10 - Zone A',
        ),
      ),
    ],
  );

  blocTest<LoginCubit, LoginState>(
    'empty fields: shows a Required error on each field',
    build: LoginCubit.new,
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
    'one empty field: only that field shows an error',
    build: LoginCubit.new,
    act: (cubit) =>
        cubit.login(name: 'Ahmed Mohamed', employeeId: '', location: 'Zone A'),
    expect: () => [const LoginState(employeeIdError: AppStrings.fieldRequired)],
  );
}
