import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_colors.dart';
import 'core/theme/app_typography.dart';
import 'core/theme/app_theme.dart';
import 'core/routes/app_routes.dart';
import 'core/providers/theme_provider.dart';

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

        if (isDesktop && child != null) {
          return Scaffold(
            backgroundColor: const Color(0xFFECEFF1), // Soft gray desktop background
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
