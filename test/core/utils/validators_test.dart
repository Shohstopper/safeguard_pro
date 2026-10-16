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
      expect(Validators.requiredField('W001'), isNull);
    });
  });
}
