import 'package:auto_login_app/src/core/services/secure_storage_service.dart';
import 'package:auto_login_app/src/core/shared/data/models/storage_model.dart';
import 'package:auto_login_app/src/core/utils/constants.dart' as constants;
import 'package:auto_login_app/src/features/login/data/models/auth_model.dart';

abstract class AuthLocalDataSource {
  Future<void> saveLogin({required AuthModel body});
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SecureStorageService storageService;

  AuthLocalDataSourceImpl({required this.storageService});

  @override
  Future<void> saveLogin({required AuthModel body}) async {
    final String jsonStringify = body.toJson();

    final StorageModel storageItem = StorageModel(
      key: constants.keyStoreLoginData,
      value: jsonStringify,
    );

    await storageService.writeSecureData(storageItem);
  }
}
