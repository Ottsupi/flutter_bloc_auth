import 'package:dio/dio.dart';

const timeoutDuration = Duration(seconds: 30);
final BaseOptions baseOptions = BaseOptions(
  connectTimeout: timeoutDuration,
  receiveTimeout: timeoutDuration,
);

final class ApiClient {
  /// To be depcrecated
  Dio get dio {
    final timeoutDuration = Duration(seconds: 30);
    final options = BaseOptions(
      connectTimeout: timeoutDuration,
      receiveTimeout: timeoutDuration,
    );
    return Dio(options);
  }
}

final class AuthApiClient {
  /// HTTP Client that the AuthenticationRepository exclusively uses.
  Dio get dio {
    return Dio(baseOptions);
  }
}

final class AppApiClient {
  /// HTTP Client that the rest of the app should use.
  Dio get dio {
    return Dio(baseOptions);
  }
}
