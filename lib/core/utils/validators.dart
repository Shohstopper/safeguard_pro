import '../constants/app_strings.dart';

/// Simple form checks. Each one returns an error message, or null if the
/// value is fine.
abstract final class Validators {
  /// Employee IDs look like "SW-001": the letters SW, a dash, three digits.
  static final RegExp _employeeIdPattern = RegExp(r'^SW-\d{3}$');

  static String? requiredField(String value) {
    if (value.trim().isEmpty) {
      return AppStrings.fieldRequired;
    }
    return null;
  }

  static String? employeeId(String value) {
    final cleanValue = value.trim().toUpperCase();
    if (cleanValue.isEmpty) {
      return AppStrings.fieldRequired;
    }
    if (!_employeeIdPattern.hasMatch(cleanValue)) {
      return AppStrings.employeeIdFormat;
    }
    return null;
  }
}
