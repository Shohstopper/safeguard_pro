import '../constants/app_strings.dart';

/// Simple form checks. Each one returns an error message, or null if the
/// value is fine.
abstract final class Validators {
  /// The field must not be empty or only spaces.
  ///
  /// Note: Employee IDs only use this check for now. The backend example
  /// uses IDs like "W001", but the exact format is not confirmed yet.
  static String? requiredField(String value) {
    if (value.trim().isEmpty) {
      return AppStrings.fieldRequired;
    }
    return null;
  }
}
