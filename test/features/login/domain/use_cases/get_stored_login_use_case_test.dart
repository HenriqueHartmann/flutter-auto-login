import 'package:auto_login_app/src/core/error/failure.dart';
import 'package:auto_login_app/src/core/shared/domain/repositories/stored_login_repository.dart';
import 'package:auto_login_app/src/features/login/data/models/auth_model.dart';
import 'package:auto_login_app/src/features/login/domain/use_cases/get_stored_login_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'mock_stored_login_repository.mocks.dart';

@GenerateMocks([StoredLoginRepository])
void main() {
  late MockStoredLoginRepository repository;
  late GetStoredLoginUseCase usecase;

  setUp(() {
    repository = MockStoredLoginRepository();
    usecase = GetStoredLoginUseCase(repository);
  });

  group(
    'Get Login UseCase',
    () {
      test(
        '#1 should get auth data with success',
        () async {
          final AuthModel auth = AuthModel(login: 'myLogin', password: '123');

          when(repository.getStoredLogin()).thenAnswer((_) async => auth);

          expect(await usecase.execute(null), auth);
        },
      );

      test(
        '#2 should get user auth data with failure',
        () async {
          when(repository.getStoredLogin())
              .thenThrow(SecureStorageEmptyFailure);

          expect(usecase.execute(null), throwsA(SecureStorageEmptyFailure));
        },
      );
    },
  );
}