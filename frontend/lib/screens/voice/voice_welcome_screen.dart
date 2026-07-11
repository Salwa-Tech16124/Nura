import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../widgets/buttons.dart';

class VoiceWelcomeScreen extends StatelessWidget {
  const VoiceWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE8F1F5), // Light sky-blue
              Color(0xFFE0F7FA), // Light cyan
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppSpacing.md),
                
                // Greeting and NURA Title with Animated Robot side-by-side
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello John 👋',
                            style: AppTypography.bodyLarge.copyWith(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "I'm NURA",
                            style: TextStyle(
                              color: Color(0xFF1E244A),
                              fontWeight: FontWeight.w900,
                              fontSize: 32,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const Text(
                            "Your AI Health Copilot",
                            style: TextStyle(
                              color: Color(0xFF2E7D32),
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    // Live Animated Robot
                    const SizedBox(
                      width: 140,
                      height: 155,
                      child: AnimatedRobot(),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                const Text(
                  "I understand your medicines, reports, symptoms and health history. How can I help you today?",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    height: 1.4,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                
                const SizedBox(height: AppSpacing.md),
                
                // Suggestions Section
                const Text(
                  'Quick Suggestions',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      _buildSuggestionCard(
                        context,
                        icon: Icons.medication_outlined,
                        color: const Color(0xFFC2F3F8), // Cyan
                        title: 'Explain my medicines',
                      ),
                      const SizedBox(height: AppSpacing.md),
                      _buildSuggestionCard(
                        context,
                        icon: Icons.description_outlined,
                        color: const Color(0xFFFED782), // Yellow
                        title: 'Summarize my latest report',
                      ),
                      const SizedBox(height: AppSpacing.md),
                      _buildSuggestionCard(
                        context,
                        icon: Icons.trending_up_outlined,
                        color: const Color(0xFFC3F3C0), // Green
                        title: 'Show my health timeline',
                      ),
                      const SizedBox(height: AppSpacing.md),
                      _buildSuggestionCard(
                        context,
                        icon: Icons.science_outlined,
                        color: const Color(0xFFE5D5FF), // Lilac
                        title: 'Explain my latest prescription',
                      ),
                    ],
                  ),
                ),
                
                // Bottom Buttons
                Column(
                  children: [
                    const SizedBox(height: AppSpacing.sm),
                    PrimaryButton(
                      text: '🎤 Start Voice Conversation',
                      onPressed: () => context.push('/voice-standby'),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    OutlinedButtonWidget(
                      text: 'Skip',
                      color: Colors.black,
                      onPressed: () => context.pop(),
                    ),
                    const SizedBox(height: AppSpacing.md),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestionCard(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required String title,
  }) {
    return GestureDetector(
      onTap: () => context.push('/voice-standby'),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black, width: 1.8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              offset: Offset(2, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 1.5),
              ),
              child: Icon(icon, color: Colors.black, size: 24),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.black54, size: 16),
          ],
        ),
      ),
    );
  }
}

class AnimatedRobot extends StatefulWidget {
  const AnimatedRobot({super.key});

  @override
  State<AnimatedRobot> createState() => _AnimatedRobotState();
}

class _AnimatedRobotState extends State<AnimatedRobot> with TickerProviderStateMixin {
  late final AnimationController _hoverController;
  late final AnimationController _waveController;
  late final Animation<double> _hoverAnimation;
  late final Animation<double> _waveAnimation;
  
  bool _isNamaste = false;

  @override
  void initState() {
    super.initState();
    
    // Hover / breathing bounce animation
    _hoverController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _hoverAnimation = Tween<double>(begin: 0.0, end: -10.0).animate(
      CurvedAnimation(
        parent: _hoverController,
        curve: Curves.easeInOut,
      ),
    );
    _hoverController.repeat(reverse: true);

    // Arm waving animation
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _waveAnimation = Tween<double>(begin: -0.1, end: 0.5).animate(
      CurvedAnimation(
        parent: _waveController,
        curve: Curves.easeInOut,
      ),
    );
    _waveController.repeat(reverse: true);

    // Alternate between Hello Wave and Namaste state activities
    _loopActivities();
  }

  Future<void> _loopActivities() async {
    while (mounted) {
      await Future.delayed(const Duration(seconds: 4));
      if (!mounted) return;
      
      setState(() {
        _isNamaste = true;
      });
      
      // Perform a Namaste jump
      _hoverController.duration = const Duration(milliseconds: 300);
      await _hoverController.forward();
      await _hoverController.reverse();
      
      await Future.delayed(const Duration(seconds: 3));
      if (!mounted) return;
      
      setState(() {
        _isNamaste = false;
      });
      _hoverController.duration = const Duration(seconds: 2);
      _hoverController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _hoverController.dispose();
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_hoverController, _waveController]),
      builder: (context, child) {
        double yOffset = _hoverAnimation.value;
        if (_isNamaste) {
          yOffset -= 12; // Extra height for the jump
        }

        return Transform.translate(
          offset: Offset(0, yOffset),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  // Outer concentric shadow/pulse
                  Container(
                    width: 110,
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xFF00E5FF).withAlpha(12),
                      shape: BoxShape.circle,
                    ),
                  ),

                  // Ears (left/right)
                  Positioned(
                    left: 12,
                    child: Container(
                      width: 8,
                      height: 18,
                      decoration: BoxDecoration(
                        color: const Color(0xFF00E5FF),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.black, width: 1.5),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 12,
                    child: Container(
                      width: 8,
                      height: 18,
                      decoration: BoxDecoration(
                        color: const Color(0xFF00E5FF),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.black, width: 1.5),
                      ),
                    ),
                  ),

                  // Robot Head
                  Container(
                    width: 76,
                    height: 68,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: Colors.black, width: 2.2),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(1.5, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Container(
                        width: 62,
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E1E2C),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Left Eye
                            Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                color: Color(0xFF00E5FF),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF00E5FF),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            // Right Eye
                            Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                color: Color(0xFF00E5FF),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF00E5FF),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Left Arm (Folded up in Namaste or waving)
                  Positioned(
                    left: 2,
                    bottom: 12,
                    child: Transform.rotate(
                      angle: _isNamaste ? 0.9 : _waveAnimation.value,
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 22,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.black, width: 1.5),
                        ),
                      ),
                    ),
                  ),

                  // Right Arm (Folded in Namaste or resting)
                  Positioned(
                    right: 2,
                    bottom: 12,
                    child: Transform.rotate(
                      angle: _isNamaste ? -0.9 : 0.2,
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 22,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.black, width: 1.5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              
              // Status Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: _isNamaste ? const Color(0xFFC3F3C0) : const Color(0xFFC2F3F8),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black, width: 1.5),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(1, 1.5),
                    ),
                  ],
                ),
                child: Text(
                  _isNamaste ? 'Namaste! 🙏' : 'Hello! 👋',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
