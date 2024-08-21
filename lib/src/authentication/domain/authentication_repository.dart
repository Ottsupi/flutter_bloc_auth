import 'dart:async';

import 'package:flutter_bloc_auth/src/authentication/data/authentication_data_source.dart';
import 'package:flutter_bloc_auth/src/authentication/data/jwt_model.dart';
import 'package:flutter_bloc_auth/src/authentication/domain/token_repository.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated, expired }

final class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  final _authenticationDataSource = AuthenticationDataSource();
  final _tokenRepository = TokenRepository();

  bool _isRefreshing = false;
  Timer _refreshTimer = Timer(Duration.zero, () {});

  Stream<AuthenticationStatus> get status async* {
    yield AuthenticationStatus.unknown;
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  // Helper methods to maintain consistency
  Future<void> _saveToken(JwtModel token) async {
    _startRefreshTimer();
    await _tokenRepository.saveToken(token: token);
  }

  Future<void> _deleteToken() async {
    _refreshTimer.cancel();
    await _tokenRepository.deleteToken();
  }

  void _startRefreshTimer() {
    _refreshTimer.cancel();
    _refreshTimer = Timer(
      _tokenRepository.refreshTokenValidity,
      () => expireSession(),
    );
  }

  // Controls app authentication state
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

  Future<void> expireSession() async {
    await _deleteToken();
    _controller.add(AuthenticationStatus.expired);
  }

  // Server authentication
  Future<void> refreshToken() async {
    if (_isRefreshing) return;

    final String? refreshToken = await _tokenRepository.getRefreshToken();
    if (refreshToken == null) return await expireSession();
    if (_tokenRepository.isRefreshTokenValid() == false) {
      return await expireSession();
    }

    _isRefreshing = true;
    final JwtModel token = await _authenticationDataSource.refresh(
      refreshToken: refreshToken,
    );
    await _saveToken(token);
    _isRefreshing = false;
  }

  Future<void> verifyAccessToken() async {
    final String? accessToken = await _tokenRepository.getAccessToken();
    if (accessToken == null) return await expireSession();
    await _authenticationDataSource.verify(token: accessToken);
  }

  // Returns an access token guaranteed to be valid.
  Future<String?> getValidAccessToken() async {
    final bool isValid = _tokenRepository.isAccessTokenValid();
    if (isValid) return await _tokenRepository.getAccessToken();
    await refreshToken();
    return await _tokenRepository.getAccessToken();
  }

  void dispose() => _controller.close();
}
