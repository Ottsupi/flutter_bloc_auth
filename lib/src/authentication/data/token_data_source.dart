import 'package:flutter_bloc_auth/src/authentication/data/jwt_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum TokenStorage { access, refresh }

extension TokenStorageX on TokenStorage {
  String get key {
    switch (this) {
      case TokenStorage.access:
        return 'access_token';
      case TokenStorage.refresh:
        return 'refresh_token';
    }
  }
}

final class TokenDataSource {
  final _storage = FlutterSecureStorage();

  Future<void> saveToken({required JwtModel token}) async {
    await _storage.write(key: TokenStorage.access.key, value: token.access);
    await _storage.write(key: TokenStorage.refresh.key, value: token.refresh);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: TokenStorage.access.key);
    await _storage.delete(key: TokenStorage.refresh.key);
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: TokenStorage.access.key);
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: TokenStorage.refresh.key);
  }
}
