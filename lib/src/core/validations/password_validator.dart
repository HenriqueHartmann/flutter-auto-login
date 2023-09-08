import 'package:auto_login_app/src/core/validations/validator.dart';

class PasswordValidator implements Validator<String> {
  @override
  bool validate(String value) {
    if (value.isEmpty) {
      return false;
    }

    return true;
  }
}
