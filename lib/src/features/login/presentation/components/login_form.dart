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
          context.read<LoginCubit>().changeToLoadedState();
        } else if (state.status == LoginStatus.success) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/dashboard', (route) => false)
              .whenComplete(
                  () => context.read<LoginCubit>().changeToLoadedState());
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
      buildWhen: (previous, current) =>
          previous.login != current.login ||
          (current.status != LoginStatus.initial &&
              current.status != LoginStatus.success),
      builder: (context, state) {
        if (state.status != LoginStatus.initial &&
            state.status != LoginStatus.success) {
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
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password ||
          (current.status != LoginStatus.initial &&
              current.status != LoginStatus.success),
      builder: (context, state) {
        if (state.status != LoginStatus.initial &&
            state.status != LoginStatus.success) {
          return TextField(
            key: const Key('loginForm_passwordInput_textField'),
            onChanged: (password) {
              context.read<LoginCubit>().onPasswordChanged(password);
            },
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Password',
              errorText: state.password.displayError == true
                  ? 'Invalid password'
                  : null,
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _RememberMeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) =>
          previous.rememberMe != current.rememberMe ||
          (current.status != LoginStatus.initial &&
              current.status != LoginStatus.success),
      builder: (context, state) {
        if (state.status != LoginStatus.initial &&
            state.status != LoginStatus.success) {
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
        }

        return const SizedBox.shrink();
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
            : state.status != LoginStatus.initial &&
                    state.status != LoginStatus.success
                ? ElevatedButton(
                    key: const Key('loginForm_continue_elevatedButton'),
                    onPressed: state.isValid
                        ? () {
                            context.read<LoginCubit>().authenticateUser();
                          }
                        : null,
                    child: const Text('Login'),
                  )
                : const SizedBox.shrink();
      },
    );
  }
}
