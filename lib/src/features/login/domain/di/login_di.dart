import 'package:auto_login_app/src/features/login/data/data_sources/auth_remote_data_source.dart';
import 'package:auto_login_app/src/features/login/data/repositories/auth_repository_impl.dart';
import 'package:auto_login_app/src/features/login/domain/repositories/auth_repository.dart';
import 'package:auto_login_app/src/features/login/domain/use_cases/get_stored_login_use_case.dart';
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
        getStoredLoginUseCase: instance(),
        cleanStoredLoginUseCase: instance(),
      ),
    );

    // Use cases
    instance.registerLazySingleton(() => LoginUseCase(instance()));
    instance.registerLazySingleton(() => SaveLoginUseCase(instance()));
    instance.registerLazySingleton(() => GetStoredLoginUseCase(instance()));

    // Repository
    instance.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: instance(),
        networkInfo: instance(),
      ),
    );

    // Data sources
    instance.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(client: instance()),
    );
  }

  LoginCubit getCubitInstance() {
    final sl = GetIt.instance;

    return sl<LoginCubit>();
  }
}
