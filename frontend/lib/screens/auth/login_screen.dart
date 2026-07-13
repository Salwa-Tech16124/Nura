import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_typography.dart';
import '../../core/constants/app_spacing.dart';
import '../../widgets/layout/page_container.dart';
import '../../providers/auth_provider.dart';
import '../../services/api_client.dart';
import '../onboarding/onboarding_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showError('Please enter your email and password.');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final authService = ref.read(authServiceProvider);
      final user = await authService.login(email, password);
      ref.read(authNotifierProvider.notifier).setUser(user);
      if (mounted) context.go('/home');
    } catch (e) {
      if (mounted) _showError(ApiClient.extractError(e));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFFEC407A),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131124),
      body: PageContainer(
        padding: EdgeInsets.zero,
        child: ScrollablePageLayout(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top Wavy Header with Cartoon Face
            SizedBox(
              height: 250,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned.fill(child: CustomPaint(painter: LoginWavePainter())),
                  Positioned(
                    left: 40, top: 25,
                    child: Icon(Icons.wb_cloudy_outlined, size: 32,
                        color: Colors.white.withAlpha(20)),
                  ),
                  Positioned(
                    right: 50, top: 35,
                    child: Icon(Icons.cloud_outlined, size: 26,
                        color: Colors.white.withAlpha(16)),
                  ),
                  Positioned(
                    left: 150, top: 45,
                    child: Icon(Icons.bubble_chart_outlined, size: 20,
                        color: Colors.white.withAlpha(18)),
                  ),
                  Positioned(
                    top: 100, left: 0, right: 0,
                    child: Center(child: CartoonFace(pageIndex: 2)),
                  ),
                ],
              ),
            ),

            // Form
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    'WELCOME BACK!',
                    style: AppTypography.h1.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 32,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'welcome back we missed you',
                    style: AppTypography.bodyMedium.copyWith(
                      color: Colors.white.withAlpha(150),
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),

                  DarkTextField(
                    hintText: 'Email Address',
                    prefixIcon: Icons.email_outlined,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  DarkTextField(
                    hintText: 'Password',
                    obscureText: true,
                    prefixIcon: Icons.lock_outline,
                    controller: _passwordController,
                  ),
                  const SizedBox(height: AppSpacing.sm),

                  // Remember me & forgot password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Theme(
                            data: ThemeData(unselectedWidgetColor: Colors.white54),
                            child: Checkbox(
                              value: _rememberMe,
                              onChanged: (v) =>
                                  setState(() => _rememberMe = v ?? false),
                              activeColor: const Color(0xFFEC407A),
                              side: const BorderSide(
                                  color: Colors.white38, width: 1.5),
                            ),
                          ),
                          Text('Remember Me',
                              style: AppTypography.bodyMedium.copyWith(
                                  color: Colors.white.withAlpha(200))),
                        ],
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text('Forgot Password?',
                            style: AppTypography.bodyMedium.copyWith(
                                color: const Color(0xFFEC407A),
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),

                  // Login button
                  Container(
                    width: double.infinity,
                    height: 52,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusPill),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF7E57C2), Color(0xFFEC407A)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFEC407A).withAlpha(50),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppSpacing.radiusPill),
                        ),
                      ),
                      onPressed: _isLoading ? null : _login,
                      child: _isLoading
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                  color: Colors.white, strokeWidth: 2.5),
                            )
                          : const Text(
                              'Sign in',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5),
                            ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Signup link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?",
                          style: AppTypography.bodyMedium
                              .copyWith(color: Colors.white.withAlpha(150))),
                      TextButton(
                        onPressed: () => context.go('/register'),
                        child: const Text('Sign Up',
                            style: TextStyle(
                                color: Color(0xFFEC407A),
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Dark Text Field ──────────────────────────────────────────────────────────
class DarkTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final IconData prefixIcon;
  final TextInputType? keyboardType;

  const DarkTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.obscureText = false,
    required this.prefixIcon,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white38, fontSize: 15),
        prefixIcon: Icon(prefixIcon, color: Colors.white54, size: 20),
        filled: true,
        fillColor: Colors.white.withAlpha(12),
        contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg, vertical: AppSpacing.md),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
          borderSide: BorderSide(color: Colors.white.withAlpha(20)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
          borderSide: BorderSide(color: Colors.white.withAlpha(20)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
          borderSide: const BorderSide(color: Color(0xFFEC407A), width: 1.5),
        ),
      ),
    );
  }
}

// ── Wave Painter ─────────────────────────────────────────────────────────────
class LoginWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = const Color(0xFF2C1E3F);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    final wavePaint = Paint()
      ..color = const Color(0xFF131124)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    const startY = 190.0;
    path.lineTo(size.width, startY);
    final w = size.width;
    path.quadraticBezierTo(w * 0.85, startY - 35, w * 0.7, startY - 10);
    path.quadraticBezierTo(w * 0.5, startY - 55, w * 0.3, startY - 10);
    path.quadraticBezierTo(w * 0.15, startY - 35, 0, startY);
    path.close();
    canvas.drawPath(path, wavePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
