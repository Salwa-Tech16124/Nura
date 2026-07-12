import 'user_profile.dart';

class LoginResponse {
  final String accessToken;
  final String tokenType;
  final UserProfile user;

  LoginResponse({
    required this.accessToken,
    required this.tokenType,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['access_token'] ?? '',
      tokenType: json['token_type'] ?? '',
      user: UserProfile.fromJson(json['user'] ?? {}),
    );
  }
}
