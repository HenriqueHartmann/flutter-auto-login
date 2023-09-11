import 'package:auto_login_app/src/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:get_it/get_it.dart';

class DashboardDI {
  void init({required GetIt instance}) {
    // Cubit
    instance.registerFactory(
      () => DashboardCubit(
        cleanStoredLoginUseCase: instance(),
      ),
    );
  }

  DashboardCubit getCubitInstance() {
    final sl = GetIt.instance;

    return sl<DashboardCubit>();
  }
}
