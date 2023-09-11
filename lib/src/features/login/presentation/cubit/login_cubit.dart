import 'package:auto_login_app/src/core/error/failure.dart';
import 'package:auto_login_app/src/core/validations/login_validator.dart';
import 'package:auto_login_app/src/core/validations/password_validator.dart';
import 'package:auto_login_app/src/features/login/data/models/auth_model.dart';
import 'package:auto_login_app/src/features/login/data/models/text_input_model.dart';
import 'package:auto_login_app/src/core/shared/domain/use_cases/clean_stored_login_use_case.dart';
import 'package:auto_login_app/src/features/login/domain/use_cases/get_stored_login_use_case.dart';
import 'package:auto_login_app/src/features/login/domain/use_cases/login_use_case.dart';
import 'package:auto_login_app/src/features/login/domain/use_cases/save_login_use_case.dart';
import 'package:auto_login_app/src/features/login/presentation/cubit/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  final SaveLoginUseCase saveLoginUseCase;
  final GetStoredLoginUseCase getStoredLoginUseCase;
  final CleanStoredLoginUseCase cleanStoredLoginUseCase;

  LoginCubit({
    required this.loginUseCase,
    required this.saveLoginUseCase,
    required this.getStoredLoginUseCase,
    required this.cleanStoredLoginUseCase,
  }) : super(const LoginState()) {
    checkStoredLogin();
  }

  void checkStoredLogin() async {
    try {
      final response = await getStoredLoginUseCase.execute(null);

      await loginUseCase.execute(response);

      emit(state.copyWith(status: LoginStatus.success));
    } on AuthenticationFailure {
      await cleanStoredLoginUseCase.execute(null);

      emit(state.copyWith(status: LoginStatus.loaded));
    } catch (e) {
      emit(state.copyWith(status: LoginStatus.failure));
    }
  }

  void onLoginChanged(
    String login,
  ) {
    bool isLoginValid = LoginValidator().validate(login);

    emit(
      state.copyWith(
        login: TextInputModel(
          inputValue: login,
          displayError: isLoginValid == false,
          isValid: isLoginValid,
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
          displayError: isPasswordValid == false,
          isValid: isPasswordValid,
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

  void authenticateUser() async {
    if (state.isValid) {
      emit(state.copyWith(status: LoginStatus.loading));
      try {
        final params = AuthModel(
          login: state.login.inputValue,
          password: state.password.inputValue,
        );

        await loginUseCase.execute(params);

        if (state.rememberMe == true) {
          await saveLoginUseCase.execute(params);
        }

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
