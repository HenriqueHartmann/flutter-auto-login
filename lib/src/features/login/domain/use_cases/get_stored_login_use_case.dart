import 'package:auto_login_app/src/core/shared/domain/repositories/stored_login_repository.dart';
import 'package:auto_login_app/src/core/use_case/use_case.dart';
import 'package:auto_login_app/src/features/login/data/models/auth_model.dart';

class GetStoredLoginUseCase extends UseCase<AuthModel, void> {
  /*
    This use case is responsible for retrieving and providing the stored 
    login information (username and password), that users have 
    chosen to save previously when utilizing the 'remember me' option. 
  */

  final StoredLoginRepository repository;

  GetStoredLoginUseCase(this.repository);

  @override
  Future<AuthModel> execute(void params) async {
    return await repository.getStoredLogin();
  }
}
