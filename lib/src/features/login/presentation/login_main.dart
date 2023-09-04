import 'package:auto_login_app/src/features/login/domain/di/login_di.dart';
import 'package:auto_login_app/src/features/login/presentation/cubit/login_cubit.dart';
import 'package:auto_login_app/src/features/login/presentation/cubit/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginMain extends StatefulWidget {
  const LoginMain({super.key});

  @override
  State<LoginMain> createState() => _LoginMainState();
}

class _LoginMainState extends State<LoginMain> {
  late LoginCubit pageBloc;

  bool rememberMe = false;

  @override
  void initState() {
    pageBloc = LoginDI().getCubitInstance();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocListener<LoginCubit, LoginState>(
        bloc: pageBloc,
        listener: (context, state) {
          if (state.status == LoginStatus.failure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Authentication Failure')),
              );
          } else if (state.status == LoginStatus.success) {
            Navigator.of(context)
                .pushNamed('/dashboard')
                .whenComplete(() => pageBloc.changeToInitState());
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Login'),
                ],
              ),
              _LoginInput(pageBloc: pageBloc),
              _PasswordInput(pageBloc: pageBloc),
              _RememberMeInput(pageBloc: pageBloc),
              _LoginButton(pageBloc: pageBloc),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginInput extends StatelessWidget {
  final LoginCubit pageBloc;

  const _LoginInput({required this.pageBloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      bloc: pageBloc,
      buildWhen: (previous, current) => previous.login != current.login,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_loginInput_textField'),
          onChanged: (login) {
            pageBloc.onLoginChanged(login);
          },
          decoration: InputDecoration(
            hintText: 'Login',
            errorText:
                state.login.displayError == true ? 'Invalid login' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  final LoginCubit pageBloc;

  const _PasswordInput({required this.pageBloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      bloc: pageBloc,
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) {
            pageBloc.onPasswordChanged(password);
          },
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Password',
            errorText:
                state.password.displayError == true ? 'Invalid password' : null,
          ),
        );
      },
    );
  }
}

class _RememberMeInput extends StatelessWidget {
  final LoginCubit pageBloc;

  const _RememberMeInput({required this.pageBloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      bloc: pageBloc,
      buildWhen: (previous, current) =>
          previous.rememberMe != current.rememberMe,
      builder: (context, state) {
        return ListTile(
          key: const Key('loginForm_rememberMeInput_radioButton'),
          title: const Text('Lembrar de mim'),
          leading: Radio<bool>(
            toggleable: true,
            value: true,
            groupValue: state.rememberMe,
            onChanged: (bool? value) {
              pageBloc.onRememberMeChanged(value ?? false);
            },
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  final LoginCubit pageBloc;

  const _LoginButton({required this.pageBloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      bloc: pageBloc,
      builder: (context, state) {
        return state.status == LoginStatus.loading
            ? const CircularProgressIndicator()
            : ElevatedButton(
                // key: const Key('loginForm_continue_raisedButton'),
                onPressed: state.isValid
                    ? () {
                        pageBloc.authenticateUser();
                      }
                    : null,
                child: const Text('Login'),
              );
      },
    );
  }
}
