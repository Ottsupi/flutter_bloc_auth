import 'package:dio/dio.dart';

final class ApiClient {
  Dio get dio {
    final timeoutDuration = Duration(seconds: 30);
    final options = BaseOptions(
      connectTimeout: timeoutDuration,
      receiveTimeout: timeoutDuration,
    );
    return Dio(options);
  }
}
