import 'package:flutter/material.dart';
import 'package:auto_login_app/src/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:auto_login_app/src/features/dashboard/presentation/cubit/dashboard_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DashboardCubit, DashboardState>(
      listener: (context, state) {
        if (state.status == DashboardStatus.exit) {
          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Dashboard'),
              ],
            ),
            const SizedBox(height: 60.0),
            ElevatedButton(
              key: const Key('dashboard_signOut_elevatedButton'),
              onPressed: () {
                context.read<DashboardCubit>().signOut();
              },
              child: const Text('Sair'),
            )
          ],
        ),
      ),
    );
  }
}
