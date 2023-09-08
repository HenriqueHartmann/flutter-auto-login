import 'package:auto_login_app/src/features/login/presentation/cubit/login_cubit.dart';
import 'package:auto_login_app/src/features/login/presentation/cubit/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
          context.read<LoginCubit>().changeToInitState();
        } else if (state.status == LoginStatus.success) {
          Navigator.of(context).pushNamed('/dashboard').whenComplete(
              () => context.read<LoginCubit>().changeToInitState());
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
            _LoginInput(),
            _PasswordInput(),
            _RememberMeInput(),
            _LoginButton(),
          ],
        ),
      ),
    );
  }
}

class _LoginInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.login != current.login,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_loginInput_textField'),
          onChanged: (login) {
            context.read<LoginCubit>().onLoginChanged(login);
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
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) {
            context.read<LoginCubit>().onPasswordChanged(password);
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
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
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
              context.read<LoginCubit>().onRememberMeChanged(value ?? false);
            },
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return state.status == LoginStatus.loading
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('loginForm_continue_elevatedButton'),
                onPressed: state.isValid
                    ? () {
                        context.read<LoginCubit>().authenticateUser();
                      }
                    : null,
                child: const Text('Login'),
              );
      },
    );
  }
}
