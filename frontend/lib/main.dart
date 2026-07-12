import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/routes/app_routes.dart';
import 'core/providers/theme_provider.dart';
import 'features/auth/providers/auth_state_provider.dart';
import 'features/auth/providers/auth_state.dart';

void main() {
  runApp(
    const ProviderScope(
      child: NuraApp(),
    ),
  );
}

class NuraApp extends ConsumerWidget {
  const NuraApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    // Listen for auth state changes (e.g. session expiration or logout) to redirect to login
    ref.listen<AuthState>(authStateProvider, (previous, next) {
      if (next.status == AuthStatus.unauthenticated) {
        final router = AppRouter.router;
        final location = router.routerDelegate.currentConfiguration.uri.path;
        if (location != '/login' && location != '/register' && location != '/onboarding' && location != '/splash') {
          router.go('/login');
        }
      }
    });

    return MaterialApp.router(
      title: 'NURA',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: AppRouter.router,
      builder: (context, child) {
        final screenWidth = MediaQuery.of(context).size.width;
        final isDesktop = screenWidth > 600;
        final isDark = Theme.of(context).brightness == Brightness.dark;

        if (isDesktop && child != null) {
          return Scaffold(
            backgroundColor: isDark ? const Color(0xFF050510) : const Color(0xFFECEFF1),
            body: Center(
              child: Container(
                width: 412, // Standard Android viewport width
                height: 892, // Standard Android viewport height
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(color: Colors.black, width: 12), // Sleek phone bezel
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 30,
                      offset: const Offset(0, 15),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: child,
                ),
              ),
            ),
          );
        }
        return child ?? const SizedBox();
      },
    );
  }
}
