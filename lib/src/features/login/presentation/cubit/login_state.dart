import 'package:auto_login_app/src/features/login/data/models/text_input_model.dart';

enum LoginStatus {
  initial,
  loading,
  success,
  failure,
}

final class LoginState {
  final LoginStatus status;
  final TextInputModel login;
  final TextInputModel password;
  final bool rememberMe;
  final bool isValid;

  const LoginState({
    this.status = LoginStatus.initial,
    this.login = const TextInputModel(),
    this.password = const TextInputModel(),
    this.rememberMe = false,
    this.isValid = false,
  });

  LoginState copyWith({
    LoginStatus? status,
    TextInputModel? login,
    TextInputModel? password,
    bool? rememberMe,
    bool? isValid,
  }) {
    return LoginState(
      status: status ?? this.status,
      login: login ?? this.login,
      password: password ?? this.password,
      rememberMe: rememberMe ?? this.rememberMe,
      isValid: isValid ?? this.isValid,
    );
  }

  bool isFieldsValid() {
    return login.isValid == true && password.isValid == true;
  }
}
