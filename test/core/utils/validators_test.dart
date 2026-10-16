import 'package:flutter_test/flutter_test.dart';
import 'package:safeguard_pro/core/constants/app_strings.dart';
import 'package:safeguard_pro/core/utils/validators.dart';

void main() {
  group('requiredField', () {
    test('rejects empty and blank text', () {
      expect(Validators.requiredField(''), AppStrings.fieldRequired);
      expect(Validators.requiredField('   '), AppStrings.fieldRequired);
    });

    test('accepts normal text', () {
      expect(Validators.requiredField('Ahmad'), isNull);
    });
  });

  group('employeeId', () {
    test('accepts SW-001, also in lowercase or with spaces', () {
      expect(Validators.employeeId('SW-001'), isNull);
      expect(Validators.employeeId(' sw-123 '), isNull);
    });

    test('rejects empty text', () {
      expect(Validators.employeeId(''), AppStrings.fieldRequired);
    });

    test('rejects the wrong format', () {
      expect(Validators.employeeId('SW001'), AppStrings.employeeIdFormat);
      expect(Validators.employeeId('SW-01'), AppStrings.employeeIdFormat);
      expect(Validators.employeeId('AB-001'), AppStrings.employeeIdFormat);
    });
  });
}
