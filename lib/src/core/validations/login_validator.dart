import 'package:auto_login_app/src/core/validations/validator.dart';

class LoginValidator implements Validator<String> {
  @override
  bool validate(String value) {
    if (value.isEmpty) {
      return true;
    }

    return false;
  }
}
