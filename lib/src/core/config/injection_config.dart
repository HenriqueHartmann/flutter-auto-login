import 'package:auto_login_app/src/core/network/network_info.dart';
import 'package:auto_login_app/src/features/login/domain/di/login_di.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

class InjectionConfig {
  final sl = GetIt.instance;

  Future<void> init() async {
    sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
    sl.registerLazySingleton(() => http.Client());

    LoginDI().init(instance: sl);
  }
}
