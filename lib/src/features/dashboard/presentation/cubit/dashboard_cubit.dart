import 'package:auto_login_app/src/core/shared/domain/use_cases/clean_stored_login_use_case.dart';
import 'package:auto_login_app/src/features/dashboard/presentation/cubit/dashboard_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final CleanStoredLoginUseCase cleanStoredLoginUseCase;

  DashboardCubit({
    required this.cleanStoredLoginUseCase,
  }) : super(const DashboardState());

  void signOut() async {
    await cleanStoredLoginUseCase.execute(null);

    emit(state.copyWith(status: DashboardStatus.exit));
  }
}
