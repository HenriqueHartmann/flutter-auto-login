import 'package:auto_login_app/src/core/shared/domain/repositories/stored_login_repository.dart';
import 'package:auto_login_app/src/core/use_case/use_case.dart';

class CleanStoredLoginUseCase extends UseCase<void, void> {
  /*
    This use case focuses on the secure deletion of stored login credentials,
    including usernames and passwords, that users have chosen to save when using 
    the 'remember me' option.
  */

  final StoredLoginRepository repository;

  CleanStoredLoginUseCase(this.repository);

  @override
  Future<void> execute(void params) async {
    return await repository.cleanStoredLogin();
  }
}
