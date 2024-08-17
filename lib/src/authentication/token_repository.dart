import 'package:flutter_bloc_auth/src/authentication/jwt_model.dart';
import 'package:flutter_bloc_auth/src/authentication/token_data_source.dart';

final class TokenRepository {
  final _tokenDataSource = TokenDataSource();

  static const Duration accessTokenValidity = Duration(seconds: 10);
  static const Duration refreshTokenValidity = Duration(seconds: 20);

  DateTime? _tokenTimeStamp;

  Future<void> saveToken({required JwtModel token}) async {
    await _tokenDataSource.saveToken(token: token);
    _tokenTimeStamp = DateTime.now();
  }

  Future<void> deleteToken() async {
    await _tokenDataSource.deleteToken();
    _tokenTimeStamp = null;
  }

  Future<String?> getAccessToken() async {
    return await _tokenDataSource.getAccessToken();
  }

  Future<String?> getRefreshToken() async {
    return await _tokenDataSource.getRefreshToken();
  }

  bool isAccessTokenValid() {
    if (_tokenTimeStamp == null) return false;
    return DateTime.now().difference(_tokenTimeStamp!) < accessTokenValidity;
  }

  bool isRefreshTokenValid() {
    if (_tokenTimeStamp == null) return false;
    return DateTime.now().difference(_tokenTimeStamp!) < refreshTokenValidity;
  }
}
