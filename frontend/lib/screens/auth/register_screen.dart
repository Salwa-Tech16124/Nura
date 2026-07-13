import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_typography.dart';
import '../../core/constants/app_spacing.dart';
import '../../widgets/layout/page_container.dart';
import '../../providers/auth_provider.dart';
import '../../services/api_client.dart';
import '../auth/login_screen.dart' show DarkTextField, LoginWavePainter;

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final password = _passwordController.text;
    final confirm = _confirmPasswordController.text;

    if (name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty) {
      _showError('Please fill in all required fields.');
      return;
    }
    if (password != confirm) {
      _showError('Passwords do not match.');
      return;
    }
    if (password.length < 6) {
      _showError('Password must be at least 6 characters.');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final authService = ref.read(authServiceProvider);

      // Register the user
      await authService.register(
        name: name,
        email: email,
        phone: phone,
        password: password,
      );

      // Auto-login after registration
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
            // Top Wavy Header with Back Button
            SizedBox(
              height: 250,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned.fill(child: CustomPaint(painter: LoginWavePainter())),
                  Positioned(
                    left: 50, top: 25,
                    child: Icon(Icons.wb_cloudy_outlined, size: 28,
                        color: Colors.white.withAlpha(20)),
                  ),
                  Positioned(
                    right: 60, top: 30,
                    child: Icon(Icons.cloud_outlined, size: 24,
                        color: Colors.white.withAlpha(16)),
                  ),
                  Positioned(
                    top: 20, left: 20,
                    child: GestureDetector(
                      onTap: () => context.go('/login'),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(60),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.arrow_back_ios_new,
                            color: Colors.white, size: 18),
                      ),
                    ),
                  ),
                  // Register illustration
                  Positioned(
                    top: 55, left: 0, right: 0,
                    child: Center(
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withAlpha(15),
                          border: Border.all(
                              color: Colors.white.withAlpha(30), width: 2),
                        ),
                        child: const Icon(Icons.person_add_outlined,
                            size: 60, color: Colors.white70),
                      ),
                    ),
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
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'GET STARTED FREE',
                    style: AppTypography.h1.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 28,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'Free Forever. No Credit Card Needed.',
                    style: AppTypography.bodyMedium
                        .copyWith(color: Colors.white.withAlpha(150), fontSize: 15),
                  ),
                  const SizedBox(height: AppSpacing.xl),

                  DarkTextField(
                    hintText: 'Full Name',
                    prefixIcon: Icons.person_outline,
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  DarkTextField(
                    hintText: 'Email Address',
                    prefixIcon: Icons.email_outlined,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  DarkTextField(
                    hintText: 'Phone Number',
                    prefixIcon: Icons.phone_outlined,
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  DarkTextField(
                    hintText: 'Password',
                    obscureText: true,
                    prefixIcon: Icons.lock_outline,
                    controller: _passwordController,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  DarkTextField(
                    hintText: 'Confirm Password',
                    obscureText: true,
                    prefixIcon: Icons.lock_outline,
                    controller: _confirmPasswordController,
                  ),
                  const SizedBox(height: AppSpacing.xxl),

                  // Register button
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
                      onPressed: _isLoading ? null : _register,
                      child: _isLoading
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                  color: Colors.white, strokeWidth: 2.5),
                            )
                          : const Text(
                              'Create Account',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5),
                            ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Login link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?',
                          style: AppTypography.bodyMedium
                              .copyWith(color: Colors.white.withAlpha(150))),
                      TextButton(
                        onPressed: () => context.go('/login'),
                        child: const Text('Login',
                            style: TextStyle(
                                color: Color(0xFFEC407A),
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
