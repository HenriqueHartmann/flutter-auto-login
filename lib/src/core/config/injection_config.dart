import 'package:auto_login_app/src/core/network/network_info.dart';
import 'package:auto_login_app/src/core/services/secure_storage_service.dart';
import 'package:auto_login_app/src/core/shared/data/data_sources/stored_login_local_data_source.dart';
import 'package:auto_login_app/src/core/shared/data/repositories/stored_login_repository_impl.dart';
import 'package:auto_login_app/src/core/shared/domain/repositories/stored_login_repository.dart';
import 'package:auto_login_app/src/core/shared/domain/use_cases/clean_stored_login_use_case.dart';
import 'package:auto_login_app/src/features/dashboard/domain/di/dashboard_di.dart';
import 'package:auto_login_app/src/features/login/domain/di/login_di.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

class InjectionConfig {
  final sl = GetIt.instance;

  Future<void> init() async {
    sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
    sl.registerLazySingleton(() => http.Client());
    sl.registerLazySingleton<SecureStorageService>(
        () => SecureStorageService());

    // Use cases
    sl.registerLazySingleton(() => CleanStoredLoginUseCase(sl()));

    // Repository
    sl.registerLazySingleton<StoredLoginRepository>(
      () => StoredLoginRepositoryImpl(
        localDataSource: sl(),
      ),
    );

    // Data sources
    sl.registerLazySingleton<StoredLoginLocalDataSource>(
      () => StoredLoginLocalDataSourceImpl(storageService: sl()),
    );

    LoginDI().init(instance: sl);
    DashboardDI().init(instance: sl);
  }
}
