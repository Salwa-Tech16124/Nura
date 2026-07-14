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
      'image': 'assets/images/onboarding/onboarding_welcome.jpg',
    },
    {
      'title': 'Medication & Tracking',
      'description': 'Never miss a dose. Track your vitals and generate comprehensive reports for your doctor automatically.',
      'image': 'assets/images/onboarding/onboarding_medication.jpg',
    },
    {
      'title': 'AI Care Companion',
      'description': 'Interact with your intelligent Voice Assistant, trigger Emergency SOS, and keep your family informed.',
      'image': 'assets/images/onboarding/onboarding_companion.jpg',
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
      backgroundColor: Colors.white, // Pure white background to match illustration backdrops
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
                        // Illustration Area
                        Expanded(
                          child: Center(
                            child: Image.asset(
                              _pages[index]['image']!,
                              height: 250,
                              width: 250,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: AppSpacing.lg),
                        
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
