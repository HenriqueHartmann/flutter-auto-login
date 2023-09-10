
import 'package:auto_login_app/src/core/error/failure.dart';
import 'package:auto_login_app/src/core/services/secure_storage_service.dart';
import 'package:auto_login_app/src/core/shared/data/models/storage_model.dart';
import 'package:auto_login_app/src/features/login/data/models/auth_model.dart';
import 'package:auto_login_app/src/core/utils/constants.dart' as constants;

abstract class StoredLoginLocalDataSource {
  Future<void> saveLogin({required AuthModel body});
  Future<AuthModel> getStoredLogin();
  Future<void> cleanStoredLogin();
}

class StoredLoginLocalDataSourceImpl implements StoredLoginLocalDataSource {
  final SecureStorageService storageService;

  StoredLoginLocalDataSourceImpl({required this.storageService});

  @override
  Future<void> saveLogin({required AuthModel body}) async {
    final String jsonStringify = body.toJson();

    final StorageModel storageItem = StorageModel(
      key: constants.keyStoreLoginData,
      value: jsonStringify,
    );

    await storageService.writeSecureData(storageItem);
  }

  @override
  Future<AuthModel> getStoredLogin() async {
    final String? jsonStringify =
        await storageService.readSecureData(constants.keyStoreLoginData);

    if (jsonStringify != null) {
      try {
        return AuthModel.fromJson(jsonStringify);
      } catch (e) {
        rethrow;
      }
    }

    throw SecureStorageEmptyFailure();
  }

  @override
  Future<void> cleanStoredLogin() async {
    await storageService.deleteSecureData(constants.keyStoreLoginData);
  }
}
