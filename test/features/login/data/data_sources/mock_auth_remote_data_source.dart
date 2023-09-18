import 'package:auto_login_app/src/core/error/failure.dart';
import 'package:auto_login_app/src/features/login/data/data_sources/auth_remote_data_source.dart';
import 'package:auto_login_app/src/features/login/data/models/auth_model.dart';
import 'package:auto_login_app/src/features/login/data/models/user_model.dart';
import 'package:mockito/mockito.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {
  @override
  Future<UserModel> authenticate({required AuthModel body}) async {
    if (body.login != 'myLogin' || body.password != '123') {
      throw AuthenticationFailure();
    }

    return const UserModel(username: 'myLogin', accessToken: 'accessToken');
  }
}
