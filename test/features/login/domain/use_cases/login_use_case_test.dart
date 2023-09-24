import 'package:auto_login_app/src/core/error/failure.dart';
import 'package:auto_login_app/src/features/login/data/models/auth_model.dart';
import 'package:auto_login_app/src/features/login/data/models/user_model.dart';
import 'package:auto_login_app/src/features/login/domain/repositories/auth_repository.dart';
import 'package:auto_login_app/src/features/login/domain/use_cases/login_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_use_case_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late MockAuthRepository repository;
  late LoginUseCase usecase;

  setUp(() {
    repository = MockAuthRepository();
    usecase = LoginUseCase(repository);
  });

  group(
    'Login UseCase',
    () {
      test(
        '#1 should authenticate the user with success',
        () async {
          final AuthModel auth = AuthModel(login: 'myLogin', password: '123');

          when(repository.authenticate(body: auth)).thenAnswer((_) async =>
              const UserModel(username: 'myLogin', accessToken: 'accessToken'));

          expect(await usecase.execute(auth), isA<UserModel>());
        },
      );

      test(
        '#2 should authenticate the user with failure',
        () async {
          final AuthModel auth = AuthModel(login: 'myLogin', password: '123');

          when(repository.authenticate(body: auth))
              .thenThrow(AuthenticationFailure);

          expect(usecase.execute(auth), throwsA(AuthenticationFailure));
        },
      );
    },
  );
}
