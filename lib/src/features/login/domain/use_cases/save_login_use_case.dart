import 'package:auto_login_app/src/core/use_case/use_case.dart';
import 'package:auto_login_app/src/features/login/data/models/auth_model.dart';
import 'package:auto_login_app/src/features/login/domain/repositories/auth_repository.dart';

class SaveLoginUseCase extends UseCase<void, AuthModel> {
  /*
    This use case is responsible for saving the user's login information, 
    such as the username and password (possibly in a secure and encrypted 
    manner), when the "remember me" option is checked. It should only be 
    invoked if the user explicitly chooses to remember their login.
  */

  final AuthRepository repository;

  SaveLoginUseCase(this.repository);

  @override
  Future<void> execute(AuthModel params) async {
    await repository.saveLogin(body: params);
  }
}
