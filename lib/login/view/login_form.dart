import 'package:bloc_form_validate/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
                const SnackBar(content: Text('Authentication Failure')));
        }
      },
      child: const Align(
        alignment: Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _UsernameInput(),
            Padding(padding: EdgeInsets.all(12)),
            _EmailInput(),
            Padding(padding: EdgeInsets.all(12)),
            _PasswordInput(),
            Padding(padding: EdgeInsets.all(12)),
            _LoginButton(),
          ],
        ),
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  const _UsernameInput({super.key});

  @override
  Widget build(BuildContext context) {
    final displayError =
        context.select((LoginBloc bloc) => bloc.state.username.displayError);
    return TextField(
      key: const Key('loginForm_usernameInput_textField'),
      onChanged: (value) {
        context.read<LoginBloc>().add(LoginUsernameChanged(value));
      },
      decoration: InputDecoration(
          labelText: 'username',
          errorText: displayError != null ? 'invalid username' : null),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (LoginBloc bloc) => bloc.state.password.displayError,
    );

    return TextField(
      key: const Key('loginForm_passwordInput_textField'),
      onChanged: (password) {
        context.read<LoginBloc>().add(LoginPasswordChanged(password));
      },
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'password',
        errorText: displayError != null ? 'invalid password' : null,
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (LoginBloc bloc) => bloc.state.email.displayError,
    );

    return TextField(
      key: const Key('loginForm_emaildInput_textField'),
      onChanged: (email) {
        context.read<LoginBloc>().add(LoginEmailChanged(email));
      },
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'email',
        errorText: displayError != null ? 'invalid email' : null,
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isInProgressOrSuccess = context.select(
      (LoginBloc bloc) => bloc.state.status.isInProgressOrSuccess,
    );

    if (isInProgressOrSuccess) return const CircularProgressIndicator();

    final isValid = context.select((LoginBloc bloc) => bloc.state.isValid);

    return ElevatedButton(
      key: const Key('loginForm_continue_raisedButton'),
      onPressed: isValid
          ? () => context.read<LoginBloc>().add(const LoginSubmitted())
          : () => context.read<LoginBloc>().add(const LoginSubmitted()),
      child: const Text('Login'),
    );
  }
}
