import 'package:dio/dio.dart';
import 'package:flutter_bloc_auth/src/core/api_client.dart';
import 'package:flutter_bloc_auth/src/core/constants.dart';

final class HelloRepository {
  final Dio dio = ApiClient().dio;

  Future<void> hello() async {
    await dio.get(ApiUrl.hello);
  }
}
