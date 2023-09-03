import 'package:auto_login_app/src/features/login/data/data_sources/auth_remote_data_source.dart';
import 'package:auto_login_app/src/features/login/data/models/auth_model.dart';
import 'package:auto_login_app/src/features/login/data/models/user_model.dart';
import 'package:auto_login_app/src/features/login/domain/repositories/auth_repository.dart';
import 'package:logger/logger.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  Logger logger = Logger();

  @override
  Future<UserModel> authenticate({required AuthModel body}) async {
    try {
      final response = await remoteDataSource.authenticate(body: body);
      logger.i('authenticate: Response was a Success');

      return response;
    } catch (e, s) {
      logger.f("authenticate: An error ocurred", error: e, stackTrace: s);
      rethrow;
    }
  }
}
