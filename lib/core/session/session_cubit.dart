import 'package:flutter_bloc/flutter_bloc.dart';

import 'session_state.dart';
import 'shift_model.dart';
import 'worker_model.dart';

/// Remembers who is signed in and their active shift, for the whole app.
class SessionCubit extends Cubit<SessionState> {
  SessionCubit() : super(const SessionState());

  /// Called after the login screen.
  void signIn(WorkerModel worker) => emit(SessionState(worker: worker));

  /// Called after the backend has started the shift session.
  void startShift(ShiftModel shift) {
    emit(SessionState(worker: state.worker, shift: shift));
  }

  /// Called when the shift ends. Clears everything.
  void signOut() => emit(const SessionState());
}
