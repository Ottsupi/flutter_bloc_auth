import 'dart:async';

import 'package:flutter_bloc_auth/src/authentication/authentication_data_source.dart';
import 'package:flutter_bloc_auth/src/authentication/token_data_source.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  final _authenticationDataSource = AuthenticationDataSource();
  final _tokenDataSource = TokenDataSource();

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
    final token = await _authenticationDataSource.login(
      username: username,
      password: password,
    );
    await _tokenDataSource.saveToken(token: token);
    _controller.add(AuthenticationStatus.authenticated);
  }

  Future<void> logOut() async {
    await _tokenDataSource.deleteToken();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
