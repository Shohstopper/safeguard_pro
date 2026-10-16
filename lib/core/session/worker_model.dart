import 'package:equatable/equatable.dart';

/// The worker who is signed in. It lives in core because both the login
/// feature and the device setup feature need it.
class WorkerModel extends Equatable {
  const WorkerModel({
    required this.name,
    required this.employeeId,
    required this.location,
  });

  /// Builds a worker from the JSON we expect from the backend.
  /// Note: the real API is not ready yet, so these key names are our best
  /// guess. Update them here when the backend team shares the real response.
  factory WorkerModel.fromJson(Map<String, dynamic> json) {
    return WorkerModel(
      name: json['name'] as String,
      employeeId: json['employee_id'] as String,
      location: json['location'] as String,
    );
  }

  final String name;
  final String employeeId;
  final String location;

  @override
  List<Object> get props => [name, employeeId, location];
}
