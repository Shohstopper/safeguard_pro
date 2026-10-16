import 'package:flutter_bloc/flutter_bloc.dart';

import 'worker_model.dart';

/// Remembers who is signed in, for the whole app.
///
/// The state is the signed-in worker, or null when nobody is signed in.
class SessionCubit extends Cubit<WorkerModel?> {
  SessionCubit() : super(null);

  void signIn(WorkerModel worker) => emit(worker);

  void signOut() => emit(null);
}
