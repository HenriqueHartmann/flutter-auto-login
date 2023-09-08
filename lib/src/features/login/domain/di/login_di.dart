import 'package:auto_login_app/src/features/login/data/data_sources/auth_local_data_source.dart';
import 'package:auto_login_app/src/features/login/data/data_sources/auth_remote_data_source.dart';
import 'package:auto_login_app/src/features/login/data/repositories/auth_repository_impl.dart';
import 'package:auto_login_app/src/features/login/domain/repositories/auth_repository.dart';
import 'package:auto_login_app/src/features/login/domain/use_cases/login_use_case.dart';
import 'package:auto_login_app/src/features/login/domain/use_cases/save_login_use_case.dart';
import 'package:auto_login_app/src/features/login/presentation/cubit/login_cubit.dart';
import 'package:get_it/get_it.dart';

class LoginDI {
  void init({required GetIt instance}) {
    // Cubit
    instance.registerFactory(
      () => LoginCubit(
        loginUseCase: instance(),
        saveLoginUseCase: instance(),
      ),
    );

    // Use cases
    instance.registerLazySingleton(() => LoginUseCase(instance()));
    instance.registerLazySingleton(() => SaveLoginUseCase(instance()));

    // Repository
    instance.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: instance(),
        localDataSource: instance(),
        networkInfo: instance(),
      ),
    );

    // Data sources
    instance.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(client: instance()),
    );
    instance.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(storageService: instance()),
    );
  }

  LoginCubit getCubitInstance() {
    final sl = GetIt.instance;

    return sl<LoginCubit>();
  }
}
