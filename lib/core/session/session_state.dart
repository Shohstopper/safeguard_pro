import 'package:equatable/equatable.dart';

import 'shift_model.dart';
import 'worker_model.dart';

/// Who is signed in, and their active shift (if one has started).
class SessionState extends Equatable {
  const SessionState({this.worker, this.shift});

  /// Set after the login screen. Null when nobody is signed in.
  final WorkerModel? worker;

  /// Set after the smartwatch is connected and the backend session started.
  final ShiftModel? shift;

  @override
  List<Object?> get props => [worker, shift];
}
