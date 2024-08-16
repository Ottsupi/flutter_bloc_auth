import 'dart:async';

import 'package:flutter_bloc_auth/src/authentication/authentication_data_source.dart';
import 'package:flutter_bloc_auth/src/authentication/jwt_model.dart';
import 'package:flutter_bloc_auth/src/authentication/token_data_source.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated, expired }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  final _authenticationDataSource = AuthenticationDataSource();
  final _tokenDataSource = TokenDataSource();

  static const Duration _accessTokenValidity = Duration(seconds: 10);

  bool _isRefresh = false;
  Timer _refreshTimer = Timer(Duration.zero, () {});

  Stream<AuthenticationStatus> get status async* {
    yield AuthenticationStatus.unknown;
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> _saveToken(JwtModel token) async {
    _startRefreshTimer();
    await _tokenDataSource.saveToken(token: token);
  }

  Future<void> _deleteToken() async {
    _refreshTimer.cancel();
    await _tokenDataSource.deleteToken();
  }

  void _startRefreshTimer() {
    _refreshTimer.cancel();
    _refreshTimer = Timer(
      _accessTokenValidity,
      () => refreshToken(),
    );
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    final token = await _authenticationDataSource.login(
      username: username,
      password: password,
    );
    await _saveToken(token);
    _controller.add(AuthenticationStatus.authenticated);
  }

  Future<void> logOut() async {
    await _deleteToken();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  Future<void> refreshToken() async {
    if (_isRefresh) return;

    final String? refreshToken = await _tokenDataSource.getRefreshToken();
    if (refreshToken == null) return await expireSession();

    _isRefresh = true;
    final JwtModel token = await _authenticationDataSource.refresh(
      refreshToken: refreshToken,
    );
    await _saveToken(token);
    _isRefresh = false;
  }

  Future<void> verifyAccessToken() async {
    final String? accessToken = await _tokenDataSource.getAccessToken();
    if (accessToken == null) return await expireSession();
    await _authenticationDataSource.verify(token: accessToken);
  }

  Future<String?> getAccessToken() async {
    return await _tokenDataSource.getAccessToken();
  }

  Future<void> expireSession() async {
    await _deleteToken();
    _controller.add(AuthenticationStatus.expired);
  }

  void dispose() => _controller.close();
}
