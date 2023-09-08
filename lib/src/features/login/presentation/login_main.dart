import 'package:auto_login_app/src/features/login/domain/di/login_di.dart';
import 'package:auto_login_app/src/features/login/presentation/components/login_form.dart';
import 'package:auto_login_app/src/features/login/presentation/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginMain extends StatefulWidget {
  const LoginMain({super.key});

  @override
  State<LoginMain> createState() => _LoginMainState();
}

class _LoginMainState extends State<LoginMain> {
  final LoginCubit pageBloc = LoginDI().getCubitInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocProvider(
        create: (context) {
          return pageBloc;
        },
        child: const LoginForm(),
      ),
    );
  }
}
