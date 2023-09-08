import 'package:auto_login_app/src/core/error/exception.dart';
import 'package:auto_login_app/src/core/network/network_info.dart';
import 'package:auto_login_app/src/features/login/data/data_sources/auth_remote_data_source.dart';
import 'package:auto_login_app/src/features/login/data/models/auth_model.dart';
import 'package:auto_login_app/src/features/login/data/models/user_model.dart';
import 'package:auto_login_app/src/features/login/domain/repositories/auth_repository.dart';
import 'package:logger/logger.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  Logger logger = Logger();

  @override
  Future<UserModel> authenticate({required AuthModel body}) async {
    bool isConnected = await networkInfo.isConnected;

    if (isConnected == true) {
      try {
        final response = await remoteDataSource.authenticate(body: body);
        
        logger.i('authenticate: Response was a Success');

        return response;
      } catch (e, s) {
        logger.f("authenticate: An error ocurred", error: e, stackTrace: s);

        rethrow;
      }
    }

    throw ConnectionException();    
  }
}
