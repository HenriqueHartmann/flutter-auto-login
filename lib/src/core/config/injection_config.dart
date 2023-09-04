import 'package:auto_login_app/src/features/login/domain/di/login_di.dart';
import 'package:get_it/get_it.dart';

class InjectionConfig {
  final sl = GetIt.instance;

  Future<void> init() async {
    LoginDI().init(instance: sl);
  }
}
