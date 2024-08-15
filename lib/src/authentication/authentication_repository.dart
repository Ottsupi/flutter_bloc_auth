import 'dart:async';

import 'package:flutter_bloc_auth/src/authentication/authentication_data_source.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  final _authenticationDataSource = AuthenticationDataSource();

  Stream<AuthenticationStatus> get status async* {
    yield AuthenticationStatus.unknown;
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    await _authenticationDataSource.login(
      username: username,
      password: password,
    );
    _controller.add(AuthenticationStatus.authenticated);
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
