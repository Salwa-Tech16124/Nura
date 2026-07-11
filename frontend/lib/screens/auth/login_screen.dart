import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_typography.dart';
import '../../core/constants/app_spacing.dart';
import '../../widgets/layout/page_container.dart';
import '../onboarding/onboarding_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131124), // Premium dark theme body
      body: PageContainer(
        padding: EdgeInsets.zero, // Zero padding to allow header waves to touch the sides
        child: ScrollablePageLayout(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top Wavy Header with Cartoon Face
            SizedBox(
              height: 250,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Wavy background region
                  Positioned.fill(
                    child: CustomPaint(
                      painter: LoginWavePainter(),
                    ),
                  ),
                  // Background cloud emoji outlines
                  Positioned(
                    left: 40,
                    top: 25,
                    child: Icon(
                      Icons.wb_cloudy_outlined,
                      size: 32,
                      color: Colors.white.withAlpha(20),
                    ),
                  ),
                  Positioned(
                    right: 50,
                    top: 35,
                    child: Icon(
                      Icons.cloud_outlined,
                      size: 26,
                      color: Colors.white.withAlpha(16),
                    ),
                  ),
                  Positioned(
                    left: 150,
                    top: 45,
                    child: Icon(
                      Icons.bubble_chart_outlined,
                      size: 20,
                      color: Colors.white.withAlpha(18),
                    ),
                  ),
                  // Centered cartoon face
                  Positioned(
                    top: 100,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: CartoonFace(pageIndex: 2), // Matching the cute teeth-smile face!
                    ),
                  ),
                ],
              ),
            ),

            // Form container section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSpacing.lg),
                  // Titles
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

                  // Inputs
                  const DarkTextField(
                    hintText: 'Email Address',
                    prefixIcon: Icons.email_outlined,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  const DarkTextField(
                    hintText: 'Password',
                    obscureText: true,
                    prefixIcon: Icons.lock_outline,
                  ),
                  const SizedBox(height: AppSpacing.sm),

                  // Remember me & forgot password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Theme(
                            data: ThemeData(
                              unselectedWidgetColor: Colors.white54,
                            ),
                            child: Checkbox(
                              value: false,
                              onChanged: (v) {},
                              activeColor: const Color(0xFFEC407A),
                              side: const BorderSide(color: Colors.white38, width: 1.5),
                            ),
                          ),
                          Text(
                            'Remember Me',
                            style: AppTypography.bodyMedium.copyWith(color: Colors.white.withAlpha(200)),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot Password?',
                          style: AppTypography.bodyMedium.copyWith(
                            color: const Color(0xFFEC407A),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),

                  // Gradient button
                  Container(
                    width: double.infinity,
                    height: 52,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF7E57C2), // Indigo purple
                          Color(0xFFEC407A), // Vibrant Pink/Magenta
                        ],
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
                          borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
                        ),
                      ),
                      onPressed: () => context.go('/home'),
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Bottom signup link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: AppTypography.bodyMedium.copyWith(color: Colors.white.withAlpha(150)),
                      ),
                      TextButton(
                        onPressed: () => context.go('/register'),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Color(0xFFEC407A),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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

// ----------------------------------------------------------------------
// Custom Text Field for Dark Mode Form inputs
// ----------------------------------------------------------------------
class DarkTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final IconData prefixIcon;

  const DarkTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.obscureText = false,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white38, fontSize: 15),
        prefixIcon: Icon(prefixIcon, color: Colors.white54, size: 20),
        filled: true,
        fillColor: Colors.white.withAlpha(12),
        contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
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

// ----------------------------------------------------------------------
// Painter for Login top wave background
// ----------------------------------------------------------------------
class LoginWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Top background region (pastel wine red background behind character)
    final bgPaint = Paint()..color = const Color(0xFF2C1E3F);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    // Wave color (dark body color: const Color(0xFF131124))
    final wavePaint = Paint()
      ..color = const Color(0xFF131124)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);

    double startY = 190;
    path.lineTo(size.width, startY);

    double w = size.width;
    path.quadraticBezierTo(w * 0.85, startY - 35, w * 0.7, startY - 10);
    path.quadraticBezierTo(w * 0.5, startY - 55, w * 0.3, startY - 10);
    path.quadraticBezierTo(w * 0.15, startY - 35, 0, startY);

    path.close();
    canvas.drawPath(path, wavePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
