import 'package:dio/dio.dart';
import '../services/secure_storage_service.dart';

/// Interceptor to append Authorization JWT tokens to all requests,
/// excluding login and register endpoints.
class AuthInterceptor extends Interceptor {
  final SecureStorageService _secureStorageService;

  AuthInterceptor(this._secureStorageService);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final path = options.path.toLowerCase();

    // Check if the current request is for authentication (login/register) and bypass if so
    if (path.contains('/login') || path.contains('/register')) {
      return handler.next(options);
    }

    // Retrieve JWT from secure storage
    final token = await _secureStorageService.getToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }
}
