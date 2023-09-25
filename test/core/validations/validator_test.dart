import 'package:auto_login_app/src/core/validations/login_validator.dart';
import 'package:auto_login_app/src/core/validations/password_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late LoginValidator loginValidator;
  late PasswordValidator passwordValidator;

  setUp(() {
    loginValidator = LoginValidator();
    passwordValidator = PasswordValidator();
  });

  group(
    'Validators',
    () {
      test(
        '#1 should validate login with success',
        () async {
          const String value = 'MyLogin';

          expect(loginValidator.validate(value), isTrue);
        },
      );

      test(
        '#2 should validate login with failure',
        () async {
          const String value = '';

          expect(loginValidator.validate(value), isFalse);
        },
      );
      test(
        '#3 should validate password with success',
        () async {
          const String value = 'MyLogin';

          expect(passwordValidator.validate(value), isTrue);
        },
      );

      test(
        '#4 should validate password with failure',
        () async {
          const String value = '';

          expect(passwordValidator.validate(value), isFalse);
        },
      );
    },
  );
}
