import 'package:flutter/material.dart';
import 'package:flutter_bloc_auth/src/features/home/home_page.dart';
import 'package:flutter_bloc_auth/src/features/login/login_page.dart';
import 'package:flutter_bloc_auth/src/features/splash/splash_page.dart';

final class AppRouter {
  static const String initialRoute = LoginPage.routeName;

  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashPage.routeName:
        return SplashPage.route();
      case LoginPage.routeName:
        return LoginPage.route();
      case HomePage.routeName:
        return HomePage.route();
      default:
        return SplashPage.route();
    }
  }
}
