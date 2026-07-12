import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../widgets/layout/page_container.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      'title': 'Welcome to NURA',
      'description': 'Your personal AI-powered elderly healthcare companion, designed to keep you safe and healthy.',
    },
    {
      'title': 'Medication & Tracking',
      'description': 'Never miss a dose. Track your vitals and generate comprehensive reports for your doctor automatically.',
    },
    {
      'title': 'AI Care Companion',
      'description': 'Interact with your intelligent Voice Assistant, trigger Emergency SOS, and keep your family informed.',
    },
  ];

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
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
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBFC), // Clean off-white background
      body: SafeArea(
        child: PageContainer(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.sm),
              // App Brand Header
              Center(
                child: Text(
                  'NURA',
                  style: AppTypography.h3.copyWith(
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF1E244A),
                    letterSpacing: 2.0,
                  ),
                ),
              ),
              
              // Slide Illustrations and Copy
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) => setState(() => _currentPage = index),
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Illustration Area with rounded pastel backdrop
                        Expanded(
                          child: Center(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Light sky-blue curve/circle behind illustrations
                                Container(
                                  width: 210,
                                  height: 210,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFE8F1F5),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                // Custom native flat illustrations
                                if (index == 0) const WelcomeIllustration(),
                                if (index == 1) const MedicationIllustration(),
                                if (index == 2) const LaunchIllustration(),
                              ],
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: AppSpacing.xl),
                        
                        // Centered Copy
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                          child: Column(
                            children: [
                              Text(
                                _pages[index]['title']!,
                                style: const TextStyle(
                                  color: Color(0xFF1E244A),
                                  fontWeight: FontWeight.w900,
                                  fontSize: 24,
                                  letterSpacing: 0.2,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: AppSpacing.md),
                              Text(
                                _pages[index]['description']!,
                                style: const TextStyle(
                                  color: Color(0xFF5A6080),
                                  fontSize: 15,
                                  height: 1.45,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xxl),
                      ],
                    );
                  },
                ),
              ),

              // Bottom Actions (Skip, dots, Next) - Styled exactly as Image 1
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.md),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Skip Text Button
                    GestureDetector(
                      onTap: _skip,
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          color: Color(0xFF5A6080),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    
                    // Center Page Indicator Dots
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        _pages.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _currentPage == index
                                ? const Color(0xFF1A73E8) // Active blue dot
                                : const Color(0xFFCFD8DC), // Inactive grey dot
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),

                    // Next / Start Text Button
                    GestureDetector(
                      onTap: _nextPage,
                      child: Text(
                        _currentPage == _pages.length - 1 ? 'Start' : 'Next',
                        style: const TextStyle(
                          color: Color(0xFF1A73E8), // Active blue text
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------------------------------------------------
// SLIDE 1 ILLUSTRATION: Senior Safety & Care (Two Humans next to Phone)
// ------------------------------------------------------------
class WelcomeIllustration extends StatelessWidget {
  const WelcomeIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 220,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // Giant central phone
          Positioned(
            bottom: 30,
            child: Container(
              width: 85,
              height: 140,
              decoration: BoxDecoration(
                color: const Color(0xFF1E244A),
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.favorite,
                      color: Color(0xFFD84315),
                      size: 32,
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          // Left human character (Caregiver)
          Positioned(
            left: 20,
            bottom: 35,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Head
                Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFCC80),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(height: 2),
                // Torso (Coral Shirt)
                Container(
                  width: 14,
                  height: 38,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF8A65),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6),
                    ),
                  ),
                ),
                // Legs (Dark Trousers)
                Container(
                  width: 12,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Color(0xFF1A237E),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(4),
                      bottomRight: Radius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Right human character (Senior drawing/pointing)
          Positioned(
            right: 20,
            bottom: 35,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Head
                Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFE082),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(height: 2),
                // Torso (Blue Shirt)
                Container(
                  width: 14,
                  height: 38,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4FC3F7),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6),
                    ),
                  ),
                ),
                // Legs (Dark Trousers)
                Container(
                  width: 12,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Color(0xFF263238),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(4),
                      bottomRight: Radius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------
// SLIDE 2 ILLUSTRATION: Medication Checklist & Tracking (Person pushing gear next to card)
// ------------------------------------------------------------
class MedicationIllustration extends StatelessWidget {
  const MedicationIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 220,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // Giant Checklist Card
          Positioned(
            left: 30,
            bottom: 40,
            child: Container(
              width: 95,
              height: 125,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: const BoxDecoration(
                            color: Color(0xFF4CAF50),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.check, size: 8, color: Colors.white),
                        ),
                        const SizedBox(width: 6),
                        Container(width: 45, height: 6, color: const Color(0xFFCFD8DC)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: const BoxDecoration(
                            color: Color(0xFF4CAF50),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.check, size: 8, color: Colors.white),
                        ),
                        const SizedBox(width: 6),
                        Container(width: 35, height: 6, color: const Color(0xFFCFD8DC)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: const BoxDecoration(
                            color: Color(0xFFCFD8DC),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(width: 40, height: 6, color: const Color(0xFFECEFF1)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Orange gear next to it
          Positioned(
            right: 50,
            bottom: 45,
            child: Icon(
              Icons.settings,
              size: 44,
              color: const Color(0xFFFFB74D).withValues(alpha: 0.95),
            ),
          ),
          
          // Human character pushing the gear
          Positioned(
            right: 25,
            bottom: 35,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Head
                Container(
                  width: 18,
                  height: 18,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFCDD2),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(height: 2),
                // Torso (Pink/Magenta Shirt)
                Container(
                  width: 12,
                  height: 34,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE91E63),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                  ),
                ),
                // Legs (Dark Trousers)
                Container(
                  width: 10,
                  height: 22,
                  decoration: const BoxDecoration(
                    color: Color(0xFF0D47A1),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(4),
                      bottomRight: Radius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------
// SLIDE 3 ILLUSTRATION: Launch & Care Ready (Rocket launching between people)
// ------------------------------------------------------------
class LaunchIllustration extends StatelessWidget {
  const LaunchIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 220,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // Launching rocket
          Positioned(
            bottom: 45,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Rocket shape composed of clean containers
                Container(
                  width: 24,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Color(0xFF9C27B0), // Purple Rocket body
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12),
                      bottom: Radius.circular(4),
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.white70,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                // Rocket boosters flame
                Icon(
                  Icons.local_fire_department,
                  size: 26,
                  color: const Color(0xFFFF7043).withValues(alpha: 0.95),
                ),
              ],
            ),
          ),
          
          // Left human character (cheering)
          Positioned(
            left: 30,
            bottom: 35,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Head
                Container(
                  width: 18,
                  height: 18,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFCC80),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(height: 2),
                // Torso (Dark Blue Shirt)
                Container(
                  width: 12,
                  height: 35,
                  decoration: const BoxDecoration(
                    color: Color(0xFF0F172A),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                  ),
                ),
                // Legs (Yellow pants)
                Container(
                  width: 10,
                  height: 22,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFD54F),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(4),
                      bottomRight: Radius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Right human character (cheering)
          Positioned(
            right: 30,
            bottom: 35,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Head
                Container(
                  width: 18,
                  height: 18,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFE082),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(height: 2),
                // Torso (Cyan Shirt)
                Container(
                  width: 12,
                  height: 35,
                  decoration: const BoxDecoration(
                    color: Color(0xFF06B6D4),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                  ),
                ),
                // Legs (Blue pants)
                Container(
                  width: 10,
                  height: 22,
                  decoration: const BoxDecoration(
                    color: Color(0xFF1E3A8A),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(4),
                      bottomRight: Radius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
