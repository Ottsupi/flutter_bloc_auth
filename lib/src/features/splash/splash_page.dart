import 'package:flutter/material.dart';
import 'package:flutter_bloc_auth/src/core/constants.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static const routeName = RouteName.splashPage;
  static Route<void> route() {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const SplashPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('Splash Page')],
          ),
          SizedBox(height: 16),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
