import 'package:auto_login_app/src/core/validations/login_validator.dart';
import 'package:auto_login_app/src/core/validations/password_validator.dart';
import 'package:auto_login_app/src/features/login/data/models/text_input_model.dart';
import 'package:auto_login_app/src/features/login/domain/use_cases/login_use_case.dart';
import 'package:auto_login_app/src/features/login/presentation/cubit/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit({required this.loginUseCase}) : super(const LoginState());

  void onLoginChanged(
    String login,
  ) {
    bool isLoginValid = LoginValidator().validate(login);

    emit(
      state.copyWith(
        login: TextInputModel(
          inputValue: login,
          displayError: isLoginValid,
          isValid: !isLoginValid,
        ),
        isValid: state.isFieldsValid(),
      ),
    );
  }

  void onPasswordChanged(
    String password,
  ) {
    bool isPasswordValid = PasswordValidator().validate(password);

    emit(
      state.copyWith(
        password: TextInputModel(
          inputValue: password,
          displayError: isPasswordValid,
          isValid: !isPasswordValid,
        ),
        isValid: state.isFieldsValid(),
      ),
    );
  }

  void onRememberMeChanged(
    bool remeberMe,
  ) {
    emit(
      state.copyWith(
        rememberMe: remeberMe,
      ),
    );
  }

  Future<void> authenticateUser() async {
    if (state.isValid) {
      emit(state.copyWith(status: LoginStatus.loading));
      try {
        final params = LoginParams(
          login: state.login.inputValue,
          password: state.password.inputValue,
        );

        final response = await loginUseCase.execute(params);

        emit(state.copyWith(status: LoginStatus.success));
      } catch (e) {
        emit(state.copyWith(status: LoginStatus.failure));
      }
    }
  }

  void changeToInitState() {
    emit(
      state.copyWith(
        status: LoginStatus.initial,
      ),
    );
  }
}
