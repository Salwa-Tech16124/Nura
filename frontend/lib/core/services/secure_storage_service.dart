import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for [SecureStorageService].
final secureStorageServiceProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService();
});

/// Service to handle secure persistence of sensitive data like JWT token.
class SecureStorageService {
  final FlutterSecureStorage _storage;

  SecureStorageService({FlutterSecureStorage? storage})
      : _storage = storage ??
            const FlutterSecureStorage(
              webOptions: WebOptions(
                dbName: 'NuraSecureStorage',
                publicKey: 'NuraKeys',
              ),
              aOptions: AndroidOptions(
                encryptedSharedPreferences: true,
              ),
            );

  static const String _jwtTokenKey = 'nura_jwt_token';

  /// Saves the JWT token securely.
  Future<void> saveToken(String token) async {
    await _storage.write(key: _jwtTokenKey, value: token);
  }

  /// Retrieves the secured JWT token. Returns null if not found.
  Future<String?> getToken() async {
    return await _storage.read(key: _jwtTokenKey);
  }

  /// Deletes the JWT token securely.
  Future<void> deleteToken() async {
    await _storage.delete(key: _jwtTokenKey);
  }

  /// Checks if a token exists.
  Future<bool> hasToken() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}
