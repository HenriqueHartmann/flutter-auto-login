import 'package:auto_login_app/src/core/shared/domain/repositories/stored_login_repository.dart';
import 'package:auto_login_app/src/features/login/data/models/auth_model.dart';
import 'package:auto_login_app/src/features/login/domain/use_cases/save_login_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'mock_stored_login_repository.mocks.dart';

@GenerateMocks([StoredLoginRepository])
void main() {
  late MockStoredLoginRepository repository;
  late SaveLoginUseCase usecase;

  setUp(() {
    repository = MockStoredLoginRepository();
    usecase = SaveLoginUseCase(repository);
  });

  group(
    'Save Login UseCase',
    () {
      test(
        '#1 should save user auth data with success',
        () async {
          final AuthModel auth = AuthModel(login: 'myLogin', password: '123');

          when(repository.saveLogin(body: auth)).thenAnswer((_) async => true);

          expect(await usecase.execute(auth), isTrue);
        },
      );

      test(
        '#2 should save user auth data with failure',
        () async {
          final AuthModel auth = AuthModel(login: 'myLogin', password: '123');

          when(repository.saveLogin(body: auth)).thenAnswer((_) async => false);

          expect(await usecase.execute(auth), isFalse);
        },
      );
    },
  );
}
