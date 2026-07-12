import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_client.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';
import '../models/register_request.dart';
import '../models/user_profile.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return AuthService(apiClient);
});

class AuthService {
  final ApiClient _apiClient;

  AuthService(this._apiClient);

  Future<LoginResponse> login(LoginRequest request) async {
    final response = await _apiClient.post(
      '/auth/login',
      data: request.toJson(),
    );
    return LoginResponse.fromJson(response.data);
  }

  Future<void> register(RegisterRequest request) async {
    await _apiClient.post(
      '/auth/register',
      data: request.toJson(),
    );
  }

  Future<UserProfile> getProfile() async {
    final response = await _apiClient.get('/auth/profile');
    return UserProfile.fromJson(response.data);
  }
}
