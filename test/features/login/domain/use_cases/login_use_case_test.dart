import 'package:auto_login_app/src/core/error/failure.dart';
import 'package:auto_login_app/src/features/login/data/models/auth_model.dart';
import 'package:auto_login_app/src/features/login/data/models/user_model.dart';
import 'package:auto_login_app/src/features/login/domain/use_cases/login_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../data/data_sources/mock_auth_remote_data_source.dart';
import '../../data/repositories/mock_auth_repository.dart';

void main() {
  late LoginUseCase usecase;
  late MockAuthRepository repository;

  setUp(() {
    repository =
        MockAuthRepository(remoteDataSource: MockAuthRemoteDataSource());
    usecase = LoginUseCase(repository);
  });

  final AuthModel auth1 = AuthModel(login: 'myLogin', password: '123');
  final AuthModel auth2 = AuthModel(login: 'myLogin1', password: '1234');

  const UserModel user =
      UserModel(username: 'myLogin', accessToken: 'accessToken');

  test(
    '#1 should authenticate the user from the repository',
    () async {
      final result = await usecase.execute(auth1);
      expect(result, user);
    },
  );

  test(
    '#2 should authenticate the user from the repository',
    () async {
      late dynamic result;

      try {
        result = await usecase.execute(auth2);
      } catch (e) {
        result = AuthenticationFailure();
      }

      expect(result, isA<AuthenticationFailure>());
    },
  );
}
