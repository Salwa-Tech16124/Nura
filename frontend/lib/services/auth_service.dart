import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants/api_constants.dart';
import '../models/user_model.dart';
import 'api_client.dart';

/// Service responsible for communicating with the backend authentication APIs.
class AuthService {
  final _client = ApiClient.instance.dio;

  /// Registers a new user. Returns the created UserModel on success.
  Future<UserModel> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    int? age,
    String? gender,
    String? emergencyContact,
  }) async {
    final response = await _client.post(
      ApiConstants.register,
      data: {
        'name': name,
        'email': email,
        'phone_number': phone,
        'password': password,
        if (age != null) 'age': age,
        if (gender != null) 'gender': gender,
        if (emergencyContact != null && emergencyContact.isNotEmpty)
          'emergency_contact': emergencyContact,
      },
    );
    return UserModel.fromJson(response.data as Map<String, dynamic>);
  }

  /// Logs in with email + password. Stores the JWT token and user data.
  /// Returns the UserModel on success.
  Future<UserModel> login(String email, String password) async {
    final response = await _client.post(
      ApiConstants.login,
      data: {'email': email, 'password': password},
    );

    final data = response.data as Map<String, dynamic>;
    final token = data['access_token'] as String;
    final user = UserModel.fromJson(data['user'] as Map<String, dynamic>);

    // Persist token and user
    await ApiClient.saveToken(token);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(ApiConstants.userKey, user.toJsonString());

    return user;
  }

  /// Fetches the authenticated user's profile from the backend.
  Future<UserModel?> getProfile() async {
    try {
      final response = await _client.get(ApiConstants.profile);
      return UserModel.fromJson(response.data as Map<String, dynamic>);
    } catch (_) {
      // Return cached user if network fails
      return getCachedUser();
    }
  }

  /// Returns the locally cached user (from SharedPreferences).
  Future<UserModel?> getCachedUser() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(ApiConstants.userKey);
    return UserModel.fromJsonString(jsonStr);
  }

  /// Clears the session token and cached user data (logout).
  Future<void> logout() async {
    await ApiClient.clearToken();
  }

  /// Returns true if a valid JWT token is stored.
  Future<bool> isLoggedIn() async {
    return ApiClient.hasToken();
  }
}
