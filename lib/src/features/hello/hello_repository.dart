import 'package:dio/dio.dart';
import 'package:flutter_bloc_auth/src/core/api_client.dart';
import 'package:flutter_bloc_auth/src/core/constants.dart';
import 'package:get_it/get_it.dart';

final class HelloRepository {
  final Dio dio = GetIt.I.get<AppApiClient>().dio;

  Future<void> hello() async {
    await dio.get(ApiUrl.hello);
  }
}
