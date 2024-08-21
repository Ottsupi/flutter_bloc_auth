import 'package:flutter_bloc_auth/src/authentication/repository.dart';
import 'package:flutter_bloc_auth/src/core/api_client.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.I;

void setupLocator() {
  /// AuthenticationRepository contains:
  ///   - AuthenticationDataSource
  ///   - TokenDataSource
  ///   ! AuthApiClient
  ///
  /// AppApiClient contains:
  ///   - JwtInterceptor
  ///     ! AuthenticationRepository
  locator.registerSingleton(AuthenticationRepository());
  locator.registerSingleton(AppApiClient());
}
