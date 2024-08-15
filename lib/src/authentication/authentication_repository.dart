import 'dart:async';

import 'package:flutter_bloc_auth/src/authentication/authentication_data_source.dart';
import 'package:flutter_bloc_auth/src/authentication/jwt_model.dart';
import 'package:flutter_bloc_auth/src/authentication/token_data_source.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  final _authenticationDataSource = AuthenticationDataSource();
  final _tokenDataSource = TokenDataSource();
  bool _isRefresh = false;

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

  Future<void> refreshToken() async {
    if (_isRefresh) return;

    final String? refreshToken = await _tokenDataSource.getRefreshToken();
    if (refreshToken == null) return logOut();

    _isRefresh = true;
    final JwtModel token = await _authenticationDataSource.refresh(
      refreshToken: refreshToken,
    );
    await _tokenDataSource.saveToken(token: token);
    _isRefresh = false;
  }

  Future<void> verifyAccessToken() async {
    final String? accessToken = await _tokenDataSource.getAccessToken();
    if (accessToken == null) return;
    await _authenticationDataSource.verify(token: accessToken);
  }

  Future<String?> getAccessToken() async {
    return await _tokenDataSource.getAccessToken();
  }

  void dispose() => _controller.close();
}
