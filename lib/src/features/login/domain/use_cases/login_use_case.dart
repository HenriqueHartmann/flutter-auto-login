import 'package:auto_login_app/src/core/use_case/use_case.dart';
import 'package:auto_login_app/src/features/login/data/models/auth_model.dart';
import 'package:auto_login_app/src/features/login/data/models/user_model.dart';
import 'package:auto_login_app/src/features/login/domain/repositories/auth_repository.dart';

class LoginUseCase extends UseCase<UserModel, AuthModel> {
  /* 
    This use case handles the logic for authenticating the user based on the 
    provided login and password. It should verify the credentials and return 
    a result indicating whether the authentication was successful or not. 
  */

  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<UserModel> execute(AuthModel params) async {
    return await repository.authenticate(body: params);
  }
}
