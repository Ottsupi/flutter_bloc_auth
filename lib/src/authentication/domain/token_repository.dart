import 'package:flutter_bloc_auth/src/authentication/data/jwt_model.dart';
import 'package:flutter_bloc_auth/src/authentication/data/token_data_source.dart';
import 'package:flutter_bloc_auth/src/core/constants.dart';

final class TokenRepository {
  final _tokenDataSource = TokenDataSource();

  final Duration accessTokenValidity = AppSetting.accessTokenValidity;
  final Duration refreshTokenValidity = AppSetting.refreshTokenValidity;

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
