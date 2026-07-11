import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/constants/app_spacing.dart';
import '../../widgets/layout/page_container.dart';
import 'dart:math' as math;

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Rich colored waves
  final List<Color> _bgColors = [
    const Color(0xFF76D72F), // Bright Lime Green
    const Color(0xFF1AD1D1), // Bright Cyan/Teal
    const Color(0xFFE024D3), // Bright Magenta
  ];

  // Light pastel backgrounds behind header
  final List<Color> _topBgColors = [
    const Color(0xFFEEF9EC), // Light Green
    const Color(0xFFE0F7FA), // Light Cyan
    const Color(0xFFFDEEF4), // Light Pink
  ];

  final List<Map<String, String>> _pages = [
    {
      'title': 'Welcome to NURA',
      'description': 'Your personal AI-powered elderly healthcare companion, designed to keep you safe and healthy.',
      'icon': 'health_and_safety'
    },
    {
      'title': 'Medication & Health Tracking',
      'description': 'Never miss a dose. Track your vitals and generate comprehensive reports for your doctor automatically.',
      'icon': 'medication'
    },
    {
      'title': 'AI Care Companion',
      'description': 'Interact with your intelligent Voice Assistant, trigger Emergency SOS, and keep your family informed.',
      'icon': 'auto_awesome'
    },
  ];

  IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'health_and_safety': return Icons.health_and_safety;
      case 'medication': return Icons.medication;
      case 'auto_awesome': return Icons.auto_awesome;
      default: return Icons.info;
    }
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      context.go('/login');
    }
  }

  void _skip() {
    context.go('/login');
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // The inner content layout of the onboarding screen
    Widget onboardingContent = Container(
      color: _topBgColors[_currentPage],
      child: PageContainer(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppSpacing.md),
            // Header "NURA"
            Center(
              child: Text(
                'NURA',
                style: AppTypography.h2.copyWith(
                  fontWeight: FontWeight.w900,
                  color: Colors.black.withAlpha(200),
                  letterSpacing: 2.0,
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Cloud wavy colored rise background
                      Positioned.fill(
                        child: CustomPaint(
                          painter: CloudPainter(color: _bgColors[index]),
                        ),
                      ),
                      // Floating background cloud emojis (Moodpress style)
                      Positioned(
                        left: 30,
                        top: 25,
                        child: Icon(
                          Icons.wb_cloudy_outlined,
                          size: 32,
                          color: Colors.black.withAlpha(24),
                        ),
                      ),
                      Positioned(
                        right: 40,
                        top: 35,
                        child: Icon(
                          Icons.cloud_outlined,
                          size: 26,
                          color: Colors.black.withAlpha(18),
                        ),
                      ),
                      Positioned(
                        left: 150,
                        top: 45,
                        child: Icon(
                          Icons.bubble_chart_outlined,
                          size: 20,
                          color: Colors.black.withAlpha(20),
                        ),
                      ),
                      // Slide Content
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 50),
                          // Upper portion: Cartoon illustration & Face
                          SizedBox(
                            height: 220,
                            child: Stack(
                              alignment: Alignment.center,
                              clipBehavior: Clip.none,
                              children: [
                                // The floating app icon for Page 1
                                if (index == 0)
                                  Positioned(
                                    top: 10,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withAlpha(40),
                                            blurRadius: 15,
                                            offset: const Offset(0, 5),
                                          )
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.asset(
                                          'assets/images/branding/nura_app_icon.png', 
                                          height: 55, 
                                          width: 55,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                // Cute white medicine icon for Page 2
                                if (index == 1)
                                  Positioned(
                                    top: 10,
                                    child: Container(
                                      padding: const EdgeInsets.all(AppSpacing.sm),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withAlpha(40),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.medication,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                // Cute white sparkle icon for Page 3
                                if (index == 2)
                                  Positioned(
                                    top: 10,
                                    child: Container(
                                      padding: const EdgeInsets.all(AppSpacing.sm),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withAlpha(40),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.auto_awesome,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                // Animated cartoon face
                                Positioned(
                                  top: 100,
                                  child: CartoonFace(pageIndex: index),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          // Lower half content (white copy)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _pages[index]['title']!.toUpperCase(),
                                  style: AppTypography.h1.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 28,
                                    height: 1.2,
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.md),
                                Text(
                                  _pages[index]['description']!,
                                  style: AppTypography.bodyLarge.copyWith(
                                    color: Colors.white.withAlpha(220),
                                    fontSize: 16,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 50),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            // Page indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(
                _pages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == index ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index ? Colors.black : Colors.black.withAlpha(80),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            // Bottom Actions (Skip / Next + Black circle arrow button)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: _skip,
                  child: Text(
                    'Skip',
                    style: AppTypography.bodyLarge.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _nextPage,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _currentPage == _pages.length - 1 ? "Let's Start" : "Next",
                        style: AppTypography.bodyLarge.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Container(
                        width: 44,
                        height: 44,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
        ),
      ),
    );

    return Scaffold(
      body: onboardingContent,
    );
  }
}

// ----------------------------------------------------------------------
// Custom Painter for drawing the Moodpress Wavy Cloud Background
// ----------------------------------------------------------------------
class CloudPainter extends CustomPainter {
  final Color color;
  CloudPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);

    double startY = 220; // Coordinates where the cloud wave top begins
    path.lineTo(size.width, startY);

    // Draw three premium cartoon humps
    double w = size.width;
    path.quadraticBezierTo(w * 0.85, startY - 45, w * 0.7, startY - 15);
    path.quadraticBezierTo(w * 0.5, startY - 70, w * 0.3, startY - 15);
    path.quadraticBezierTo(w * 0.15, startY - 45, 0, startY);

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CloudPainter oldDelegate) => oldDelegate.color != color;
}

// ----------------------------------------------------------------------
// Custom Animated Cartoon Face (Eyes Blink, Pupils Move, Cheeks Blush)
// ----------------------------------------------------------------------
class CartoonFace extends StatefulWidget {
  final int pageIndex;
  const CartoonFace({super.key, required this.pageIndex});

  @override
  State<CartoonFace> createState() => _CartoonFaceState();
}

class _CartoonFaceState extends State<CartoonFace> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pupilOffsetAnimation;
  late Animation<double> _blinkAnimation;

  @override
  void initState() {
    super.initState();
    // 4-second loop for face micro-animations
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    // Smooth horizontal pupil looking-around tween
    _pupilOffsetAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 5.0).chain(CurveTween(curve: Curves.easeInOut)), weight: 20),
      TweenSequenceItem(tween: ConstantTween(5.0), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 5.0, end: -5.0).chain(CurveTween(curve: Curves.easeInOut)), weight: 20),
      TweenSequenceItem(tween: ConstantTween(-5.0), weight: 30),
    ]).animate(_controller);

    // Periodic quick eye-blink sequence
    _blinkAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 90),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0).chain(CurveTween(curve: Curves.easeIn)), weight: 5),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.easeOut)), weight: 5),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SizedBox(
          width: 140,
          height: 90,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              // Pink blush cheeks for page 2 (index 1)
              if (widget.pageIndex == 1) ...[
                Positioned(
                  left: 0,
                  top: 35,
                  child: Container(
                    width: 24,
                    height: 14,
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent.withAlpha(80),
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 35,
                  child: Container(
                    width: 24,
                    height: 14,
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent.withAlpha(80),
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                ),
              ],

              // Left Eye
              Positioned(
                left: 20,
                top: 15,
                child: Transform.scale(
                  scaleY: _blinkAnimation.value,
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Transform.translate(
                        offset: Offset(_pupilOffsetAnimation.value, 0),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: Align(
                            alignment: const Alignment(-0.35, -0.35),
                            child: Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Right Eye
              Positioned(
                right: 20,
                top: 15,
                child: Transform.scale(
                  scaleY: _blinkAnimation.value,
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Transform.translate(
                        offset: Offset(_pupilOffsetAnimation.value, 0),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: Align(
                            alignment: const Alignment(-0.35, -0.35),
                            child: Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Left Eyebrow
              Positioned(
                left: 22,
                top: 5,
                child: Transform.rotate(
                  angle: widget.pageIndex == 1 ? -0.08 : 0.08,
                  child: Container(
                    width: 26,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),

              // Right Eyebrow
              Positioned(
                right: 22,
                top: 5,
                child: Transform.rotate(
                  angle: widget.pageIndex == 1 ? 0.08 : -0.08,
                  child: Container(
                    width: 26,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),

              // Mouth
              Positioned(
                top: 62,
                left: 47,
                child: widget.pageIndex == 1
                    ? _buildHappyMouth()  // Happy open mouth for slide 2
                    : _buildTeethMouth(), // Smile with 2 front teeth for slides 1 & 3
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTeethMouth() {
    return Container(
      width: 46,
      height: 22,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(22),
          bottomRight: Radius.circular(22),
        ),
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 8, height: 7, color: Colors.white),
              const SizedBox(width: 2),
              Container(width: 8, height: 7, color: Colors.white),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHappyMouth() {
    return Container(
      width: 38,
      height: 28,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(19),
          bottomRight: Radius.circular(19),
        ),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: 22,
          height: 11,
          decoration: const BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(11),
              topRight: Radius.circular(11),
            ),
          ),
        ),
      ),
    );
  }
}
