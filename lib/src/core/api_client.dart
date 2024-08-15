import 'package:dio/dio.dart';
import 'package:flutter_bloc_auth/src/core/interceptors.dart';

const timeoutDuration = Duration(seconds: 30);
final BaseOptions baseOptions = BaseOptions(
  connectTimeout: timeoutDuration,
  receiveTimeout: timeoutDuration,
);

final class AuthApiClient {
  /// HTTP Client that the AuthenticationRepository exclusively uses.
  Dio get dio {
    return Dio(baseOptions);
  }
}

final class AppApiClient {
  /// HTTP Client that the rest of the app should use.
  Dio get dio {
    final dio = Dio(baseOptions);
    dio.interceptors.add(JwtInterceptor());
    return dio;
  }
}
