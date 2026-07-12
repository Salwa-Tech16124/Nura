import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../repositories/auth_repository.dart';
import '../models/login_request.dart';
import '../models/register_request.dart';
import 'auth_state.dart';

final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthNotifier(repository);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;

  AuthNotifier(this._repository) : super(AuthState.initial());

  Future<void> login(String email, String password) async {
    state = AuthState.loading();
    try {
      final request = LoginRequest(email: email, password: password);
      // 1. Perform login and save JWT
      await _repository.login(request);
      // 2. Call GET /auth/profile
      final profile = await _repository.getProfile();
      // 3. Store user profile in state
      state = AuthState.authenticated(profile);
    } on DioException catch (e) {
      state = AuthState.error(_handleDioError(e));
    } catch (e) {
      state = AuthState.error('An unexpected error occurred. Please try again.');
    }
  }

  Future<void> register(RegisterRequest request) async {
    state = AuthState.loading();
    try {
      await _repository.register(request);
      state = AuthState.unauthenticated(); // Registered successfully, now can login
    } on DioException catch (e) {
      state = AuthState.error(_handleDioError(e));
      rethrow;
    } catch (e) {
      state = AuthState.error('An unexpected error occurred. Please try again.');
      rethrow;
    }
  }

  Future<bool> checkAuthStatus() async {
    final hasToken = await _repository.hasStoredToken();
    if (!hasToken) {
      state = AuthState.unauthenticated();
      return false;
    }

    state = AuthState.loading();
    try {
      final profile = await _repository.getProfile();
      state = AuthState.authenticated(profile);
      return true;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
        await _repository.logout();
        state = AuthState.unauthenticated();
      } else {
        state = AuthState.error(_handleDioError(e));
      }
      return false;
    } catch (e) {
      state = AuthState.error('Authentication verification failed.');
      return false;
    }
  }

  Future<void> logout() async {
    await _repository.logout();
    state = AuthState.unauthenticated();
  }

  String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timed out. Please try again.';
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode == 401) {
          return 'Invalid credentials. Please check your email and password.';
        } else if (statusCode == 403) {
          return 'Access forbidden. Unauthorized request.';
        } else if (statusCode == 400) {
          final detail = error.response?.data?['detail'];
          return detail?.toString() ?? 'Bad request. Please check inputs.';
        }
        return 'Server returned an error: $statusCode';
      case DioExceptionType.connectionError:
        return 'No internet connection. Please check your network.';
      default:
        return 'Server unavailable. Please try again later.';
    }
  }
}
