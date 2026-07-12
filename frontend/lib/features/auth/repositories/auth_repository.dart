import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/secure_storage_service.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';
import '../models/register_request.dart';
import '../models/user_profile.dart';
import '../services/auth_service.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final authService = ref.watch(authServiceProvider);
  final secureStorage = ref.watch(secureStorageServiceProvider);
  return AuthRepository(authService, secureStorage);
});

class AuthRepository {
  final AuthService _authService;
  final SecureStorageService _secureStorageService;

  AuthRepository(this._authService, this._secureStorageService);

  Future<LoginResponse> login(LoginRequest request) async {
    final response = await _authService.login(request);
    await _secureStorageService.saveToken(response.accessToken);
    return response;
  }

  Future<void> register(RegisterRequest request) async {
    await _authService.register(request);
  }

  Future<UserProfile> getProfile() async {
    return await _authService.getProfile();
  }

  Future<void> logout() async {
    await _secureStorageService.deleteToken();
  }

  Future<String?> getStoredToken() async {
    return await _secureStorageService.getToken();
  }

  Future<bool> hasStoredToken() async {
    return await _secureStorageService.hasToken();
  }
}
