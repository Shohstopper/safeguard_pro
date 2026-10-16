import 'package:equatable/equatable.dart';

/// The 4 steps of ending the shift.
enum EndShiftStatus { initial, loading, success, failure }

/// Everything the "You're connected" screen needs for its End button.
class EndShiftState extends Equatable {
  const EndShiftState({
    this.status = EndShiftStatus.initial,
    this.errorMessage,
  });

  final EndShiftStatus status;

  /// Why ending the shift failed. Only set when [status] is failure.
  final String? errorMessage;

  bool get isEnding => status == EndShiftStatus.loading;

  @override
  List<Object?> get props => [status, errorMessage];
}
