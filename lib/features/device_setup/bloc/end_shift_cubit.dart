import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_strings.dart';
import '../data/session_repository.dart';
import 'end_shift_state.dart';

/// The logic for ending the shift: tells the backend the session is over.
class EndShiftCubit extends Cubit<EndShiftState> {
  // Callers pass this as `sessionRepository:` (Dart drops the underscore).
  EndShiftCubit({required this._sessionRepository})
    : super(const EndShiftState());

  final SessionRepository _sessionRepository;

  Future<void> endShift(int sessionId) async {
    if (state.isEnding) return;
    emit(const EndShiftState(status: EndShiftStatus.loading));

    try {
      await _sessionRepository.endSession(sessionId: sessionId);
      emit(const EndShiftState(status: EndShiftStatus.success));
    } on SessionException catch (error) {
      emit(
        EndShiftState(
          status: EndShiftStatus.failure,
          errorMessage: error.message,
        ),
      );
    } catch (_) {
      emit(
        const EndShiftState(
          status: EndShiftStatus.failure,
          errorMessage: AppStrings.couldNotEndShift,
        ),
      );
    }
  }
}
