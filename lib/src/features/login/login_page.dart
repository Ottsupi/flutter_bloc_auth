import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_auth/src/authentication/repository.dart';
import 'package:flutter_bloc_auth/src/core/constants.dart';
import 'package:flutter_bloc_auth/src/core/widgets.dart';
import 'package:flutter_bloc_auth/src/features/login/bloc/login_form_bloc.dart';
import 'package:formz/formz.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const routeName = RouteName.loginPage;
  static Route<void> route() {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const LoginPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginFormBloc(
        authenticationRepository: context.read<AuthenticationRepository>(),
      ),
      child: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: LoginButtonBuilder(),
      ),
    );
  }
}

class LoginButtonBuilder extends StatelessWidget {
  const LoginButtonBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginFormBloc, LoginFormState>(
      builder: (context, state) {
        if (state.status == FormzSubmissionStatus.inProgress) {
          return const CircularProgressIndicator();
        }
        return LoginButton();
      },
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DisplayButtonWidget(
      text: 'Login',
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
      onPressed: () {
        BlocProvider.of<LoginFormBloc>(context).add(
          SubmitLoginForm(),
        );
      },
    );
  }
}
