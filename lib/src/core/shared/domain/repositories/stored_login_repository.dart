import 'package:auto_login_app/src/features/login/data/models/auth_model.dart';

abstract class StoredLoginRepository {
  Future<bool> saveLogin({required AuthModel body});
  Future<AuthModel> getStoredLogin();
  Future<void> cleanStoredLogin();
}