import 'package:flutter/material.dart';
import 'package:flutter_bloc_auth/src/core/constants.dart';
import 'package:flutter_bloc_auth/src/core/widgets.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: DisplayButtonWidget(
          text: 'Login',
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          onPressed: () {
            Navigator.of(context).pushNamed(RouteName.homePage);
          },
        ),
      ),
    );
  }
}
