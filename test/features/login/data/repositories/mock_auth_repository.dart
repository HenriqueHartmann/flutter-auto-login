import 'package:auto_login_app/src/features/login/data/data_sources/auth_remote_data_source.dart';
import 'package:auto_login_app/src/features/login/data/models/auth_model.dart';
import 'package:auto_login_app/src/features/login/data/models/user_model.dart';
import 'package:auto_login_app/src/features/login/domain/repositories/auth_repository.dart';
import 'package:mockito/mockito.dart';

class MockAuthRepository extends Mock implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  MockAuthRepository({required this.remoteDataSource});

  @override
  Future<UserModel> authenticate({required AuthModel body}) async {
    final response = await remoteDataSource.authenticate(body: body);

    return response;
  }
}
