import 'package:auto_login_app/src/features/dashboard/domain/di/dashboard_di.dart';
import 'package:auto_login_app/src/features/dashboard/presentation/components/dashboard_content.dart';
import 'package:auto_login_app/src/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardMain extends StatelessWidget {
  const DashboardMain({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardCubit pageBloc = DashboardDI().getCubitInstance();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocProvider(
        create: (context) {
          return pageBloc;
        },
        child: const DashboardContent(),
      ),
    );
  }
}
