final class RouteName {
  static const String splashPage = 'splash';
  static const String loginPage = 'login';
  static const String homePage = 'home';
}

final class ApiUrl {
  static const String baseUrl = 'http://192.168.100.9:8080';

  static const String login = '$baseUrl/auth/token/';
  static const String refresh = '$baseUrl/auth/token/refresh/';
  static const String verify = '$baseUrl/auth/token/verify/';

  static const String hello = '$baseUrl/hello/user/';
}
