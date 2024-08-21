import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_auth/src/authentication/authentication.dart';
import 'package:flutter_bloc_auth/src/authentication/authentication_repository.dart';
import 'package:flutter_bloc_auth/src/core/constants.dart';

class AuthenticationListener extends StatelessWidget {
  const AuthenticationListener({
    super.key,
    required this.child,
    required this.navigatorKey,
  });

  final Widget? child;
  final GlobalKey<NavigatorState> navigatorKey;

  NavigatorState get _navigator => navigatorKey.currentState!;

  void _showAuthenticationExpiredDialog() {
    showDialog(
      barrierDismissible: false,
      context: _navigator.context,
      builder: (context) => AlertDialog(
        title: Text('Session Expired'),
        content: Text('Your session has expired. Please log in again.'),
        actions: [
          TextButton(
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(
                AuthenticationLogoutRequested(),
              );
            },
            child: Text('Return to Log In'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        switch (state.status) {
          case AuthenticationStatus.authenticated:
            _navigator.pushNamedAndRemoveUntil(
              RouteName.homePage,
              (route) => false,
            );
          case AuthenticationStatus.unauthenticated:
            _navigator.pushNamedAndRemoveUntil(
              RouteName.loginPage,
              (route) => false,
            );
          case AuthenticationStatus.expired:
            _showAuthenticationExpiredDialog();
          case AuthenticationStatus.unknown:
            return;
        }
      },
      child: child,
    );
  }
}
