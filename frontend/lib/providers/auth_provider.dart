import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';

/// Provides the AuthService singleton.
final authServiceProvider = Provider<AuthService>((ref) => AuthService());

/// Reactive state: the currently logged-in user (null if not logged in).
/// Uses StateNotifier so screens can update the user after login/profile fetch.
class AuthNotifier extends StateNotifier<AsyncValue<UserModel?>> {
  final AuthService _authService;

  AuthNotifier(this._authService) : super(const AsyncValue.loading()) {
    _loadUser();
  }

  Future<void> _loadUser() async {
    try {
      final isLoggedIn = await _authService.isLoggedIn();
      if (!isLoggedIn) {
        state = const AsyncValue.data(null);
        return;
      }
      final user = await _authService.getProfile();
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Call after successful login — updates the in-memory user.
  void setUser(UserModel user) {
    state = AsyncValue.data(user);
  }

  /// Call on logout — clears user from state.
  Future<void> logout() async {
    await _authService.logout();
    state = const AsyncValue.data(null);
  }

  /// Refreshes the profile from backend.
  Future<void> refresh() async => _loadUser();
}

/// The main auth state notifier provider.
final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<UserModel?>>((ref) {
  final service = ref.read(authServiceProvider);
  return AuthNotifier(service);
});

/// Convenience provider — just gives the user or null.
final currentUserProvider = Provider<UserModel?>((ref) {
  return ref.watch(authNotifierProvider).valueOrNull;
});

/// Convenience provider — true if logged in.
final isLoggedInProvider = Provider<bool>((ref) {
  final user = ref.watch(currentUserProvider);
  return user != null;
});
