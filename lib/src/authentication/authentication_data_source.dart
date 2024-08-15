import 'package:dio/dio.dart';
import 'package:flutter_bloc_auth/src/authentication/jwt_model.dart';
import 'package:flutter_bloc_auth/src/core/api_client.dart';
import 'package:flutter_bloc_auth/src/core/constants.dart';

final class AuthenticationDataSource {
  final Dio dio = ApiClient().dio;

  Future<JwtModel> login({
    required String username,
    required String password,
  }) async {
    // Use dart devtools to check the api call
    // Modify `data` to fit your auth credentials
    Response response = await dio.post(
      ApiUrl.login,
      data: {
        'username': username,
        'password': password,
      },
    );
    return JwtModel.fromJson(response.data);
  }

  Future<JwtModel> refresh({required String refreshToken}) async {
    Response response;
    response = await dio.post(
      ApiUrl.refresh,
      data: {
        'refresh': refreshToken,
      },
    );
    return JwtModel.fromJson(response.data);
  }

  Future<void> verify({required String token}) async {
    Response response;
    response = await dio.post(
      ApiUrl.verify,
      data: {
        'token': token,
      },
    );
    response;
  }
}
