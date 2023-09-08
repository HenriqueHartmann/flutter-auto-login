import 'package:auto_login_app/src/core/shared/data/models/storage_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final _secureStorage = const FlutterSecureStorage();

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  Future<void> writeSecureData(StorageModel newItem) async {
    await _secureStorage.write(
      key: newItem.key,
      value: newItem.value,
      aOptions: _getAndroidOptions(),
    );
  }

  Future<String?> readSecureData(String key) async {
    var readData = await _secureStorage.read(
      key: key,
      aOptions: _getAndroidOptions(),
    );
    return readData;
  }

  Future<void> deleteSecureData(StorageModel item) async {
    await _secureStorage.delete(
      key: item.key,
      aOptions: _getAndroidOptions(),
    );
  }

  Future<bool> containsKeyInSecureData(String key) async {
    var containsKey = await _secureStorage.containsKey(
      key: key,
      aOptions: _getAndroidOptions(),
    );
    return containsKey;
  }
}
