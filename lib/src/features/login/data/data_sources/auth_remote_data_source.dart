import 'package:auto_login_app/src/core/error/failure.dart';
import 'package:auto_login_app/src/features/login/data/models/auth_model.dart';
import 'package:auto_login_app/src/features/login/data/models/user_model.dart';
import 'package:auto_login_app/src/core/mixins/env_mixin.dart';
import 'package:http/http.dart' as http;

abstract class AuthRemoteDataSource {
  Future<UserModel> authenticate({required AuthModel body});
}

class AuthRemoteDataSourceImpl with EnvMixin implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> authenticate({required AuthModel body}) async {
    final host = getEnvVariable(varName: 'URL_HOST') as String;
    const path = '/api/login';
    final url = Uri.parse(host + path);

    final response = await client.post(
      url,
      body: body.toMap(),
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(response.body);
    } else if (response.statusCode == 401) {
      throw AuthenticationFailure();
    }

    throw ResponseFailure();
  }
}
