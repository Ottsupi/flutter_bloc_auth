import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_auth/src/authentication/authentication.dart';
import 'package:flutter_bloc_auth/src/core/constants.dart';
import 'package:flutter_bloc_auth/src/core/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const routeName = RouteName.homePage;
  static Route<void> route() {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const HomePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Logout(),
          ],
        ),
      ),
    );
  }
}

class Logout extends StatelessWidget {
  const Logout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DisplayButtonWidget(
      text: 'Logout',
      backgroundColor: Colors.red,
      foregroundColor: Colors.white,
      onPressed: () {
        BlocProvider.of<AuthenticationBloc>(context)
            .add(AuthenticationLogoutRequested());
      },
    );
  }
}
