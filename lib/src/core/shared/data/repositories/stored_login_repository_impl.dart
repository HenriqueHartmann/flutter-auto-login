import 'package:auto_login_app/src/core/shared/data/data_sources/stored_login_local_data_source.dart';
import 'package:auto_login_app/src/core/shared/domain/repositories/stored_login_repository.dart';
import 'package:auto_login_app/src/features/login/data/models/auth_model.dart';
import 'package:logger/logger.dart';

class StoredLoginRepositoryImpl implements StoredLoginRepository {
  final StoredLoginLocalDataSource localDataSource;

  StoredLoginRepositoryImpl({
    required this.localDataSource,
  });

  Logger logger = Logger();

  @override
  Future<bool> saveLogin({required AuthModel body}) async {
    try {
      await localDataSource.saveLogin(body: body);

      logger.i('saveLogin: Success');

      return true;
    } catch (e, s) {
      logger.f("saveLogin: An error ocurred", error: e, stackTrace: s);

      return false;
    }
  }

  @override
  Future<AuthModel> getStoredLogin() async {
    try {
      final response = await localDataSource.getStoredLogin();

      logger.i('getStoredLogin: Success');

      return response;
    } catch (e) {
      logger.i('getStoredLogin: An error ocurred');

      rethrow;
    }
  }

  @override
  Future<void> cleanStoredLogin() async {
    try {
      await localDataSource.cleanStoredLogin();
    } catch (e) {
      logger.i('cleanStoredLogin: An error ocurred');
    }
  }
}
