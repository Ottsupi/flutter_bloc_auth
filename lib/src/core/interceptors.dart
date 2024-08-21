import 'package:dio/dio.dart';
import 'package:flutter_bloc_auth/src/authentication/repository.dart';
import 'package:get_it/get_it.dart';

final class JwtInterceptor extends InterceptorsWrapper {
  final AuthenticationRepository authenticationRepository =
      GetIt.I.get<AuthenticationRepository>();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final String? accessToken =
        await authenticationRepository.getValidAccessToken();
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    handler.next(options);
  }
}
