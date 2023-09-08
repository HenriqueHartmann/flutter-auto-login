import 'package:auto_login_app/src/core/use_case/use_case.dart';
import 'package:auto_login_app/src/features/login/data/models/auth_model.dart';
import 'package:auto_login_app/src/features/login/data/models/user_model.dart';
import 'package:auto_login_app/src/features/login/domain/repositories/auth_repository.dart';

class LoginUseCase extends UseCase<UserModel, LoginParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<UserModel> execute(LoginParams params) async {
    final body = AuthModel(login: params.login, password: params.password);

    final response = await repository.authenticate(body: body);

    // TODO: Save Login

    return response;
  }
}

class LoginParams {
  final String login;
  final String password;
  final bool rememberMe;

  LoginParams({
    required this.login,
    required this.password,
    this.rememberMe = false,
  });
}
