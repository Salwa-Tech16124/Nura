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
  late final AnimationController _danceController;
  
  late final Animation<double> _hoverAnimation;
  late final Animation<double> _waveAnimation;
  late final Animation<double> _danceAnimation;
  
  int _robotActivity = 0; // 0 = Wave Hello, 1 = Namaste Jump, 2 = Dancing

  @override
  void initState() {
    super.initState();
    
    // Hover animation (gentle floating)
    _hoverController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _hoverAnimation = Tween<double>(begin: 0.0, end: -8.0).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeInOut),
    );
    _hoverController.repeat(reverse: true);

    // Wave animation (left arm waving)
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    _waveAnimation = Tween<double>(begin: -0.2, end: 0.8).animate(
      CurvedAnimation(parent: _waveController, curve: Curves.easeInOut),
    );
    _waveController.repeat(reverse: true);

    // Dance animation (tilting side to side)
    _danceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _danceAnimation = Tween<double>(begin: -0.12, end: 0.12).animate(
      CurvedAnimation(parent: _danceController, curve: Curves.easeInOut),
    );
    _danceController.repeat(reverse: true);

    _loopActivities();
  }

  Future<void> _loopActivities() async {
    while (mounted) {
      // 1. Waving Hello
      if (!mounted) return;
      setState(() => _robotActivity = 0);
      _waveController.repeat(reverse: true);
      _danceController.stop();
      await Future.delayed(const Duration(seconds: 4));
      
      // 2. Namaste Jump
      if (!mounted) return;
      setState(() => _robotActivity = 1);
      _waveController.stop();
      _danceController.stop();
      
      // Fast jump up and down
      _hoverController.duration = const Duration(milliseconds: 250);
      await _hoverController.forward();
      await _hoverController.reverse();
      _hoverController.duration = const Duration(seconds: 2);
      _hoverController.repeat(reverse: true);
      await Future.delayed(const Duration(seconds: 3));
      
      // 3. Dancing!
      if (!mounted) return;
      setState(() => _robotActivity = 2);
      _waveController.stop();
      _danceController.repeat(reverse: true);
      await Future.delayed(const Duration(seconds: 4));
    }
  }

  @override
  void dispose() {
    _hoverController.dispose();
    _waveController.dispose();
    _danceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_hoverController, _waveController, _danceController]),
      builder: (context, child) {
        double yOffset = _hoverAnimation.value;
        double tiltAngle = 0.0;
        
        if (_robotActivity == 1) {
          yOffset -= 22; // Extra height for the jump
        } else if (_robotActivity == 2) {
          tiltAngle = _danceAnimation.value; // Rock side to side
        }

        return Transform.translate(
          offset: Offset(0, yOffset),
          child: Transform.rotate(
            angle: tiltAngle,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  clipBehavior: Clip.none,
                  children: [
                    // Outer concentric shadow/pulse
                    Positioned(
                      top: 15,
                      child: Container(
                        width: 95,
                        height: 95,
                        decoration: BoxDecoration(
                          color: const Color(0xFF00E5FF).withAlpha(12),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),

                    // Main Robot Body Assembly
                    Column(
                      children: [
                        // Head
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            // Left Antenna
                            Positioned(
                              left: 0,
                              child: Container(
                                width: 5,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF00E5FF),
                                  borderRadius: BorderRadius.circular(2),
                                  border: Border.all(color: Colors.black, width: 1.2),
                                ),
                              ),
                            ),
                            // Right Antenna
                            Positioned(
                              right: 0,
                              child: Container(
                                width: 5,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF00E5FF),
                                  borderRadius: BorderRadius.circular(2),
                                  border: Border.all(color: Colors.black, width: 1.2),
                                ),
                              ),
                            ),
                            // Face & Shield
                            Container(
                              width: 54,
                              height: 48,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.black, width: 1.8),
                              ),
                              child: Center(
                                child: Container(
                                  width: 44,
                                  height: 34,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1E1E2C),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Left Eye
                                      Container(
                                        width: 7,
                                        height: 7,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF00E5FF),
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xFF00E5FF),
                                              blurRadius: 4,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      // Right Eye
                                      Container(
                                        width: 7,
                                        height: 7,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF00E5FF),
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xFF00E5FF),
                                              blurRadius: 4,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        // Neck link
                        Container(
                          width: 8,
                          height: 4,
                          color: Colors.black,
                        ),
                        
                        // Torso / Chest (glowing battery)
                        Container(
                          width: 46,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.black, width: 1.8),
                          ),
                          child: Center(
                            child: Container(
                              width: 16,
                              height: 16,
                              decoration: const BoxDecoration(
                                color: Color(0xFF00E5FF),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF00E5FF),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        
                        // Legs link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(width: 5, height: 10, color: Colors.black),
                            const SizedBox(width: 14),
                            Container(width: 5, height: 10, color: Colors.black),
                          ],
                        ),
                        
                        // Feet
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 12,
                              height: 6,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 12,
                              height: 6,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Left Arm (Folded in Namaste or waving)
                    Positioned(
                      left: -12,
                      top: 55,
                      child: Transform.rotate(
                        angle: _robotActivity == 1
                            ? 0.9 // Namaste
                            : (_robotActivity == 0
                                ? _waveAnimation.value // Wave
                                : -0.3 + (_danceAnimation.value * 2)), // Dance
                        alignment: Alignment.topRight,
                        child: Container(
                          width: 20,
                          height: 7,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(3.5),
                            border: Border.all(color: Colors.black, width: 1.5),
                          ),
                        ),
                      ),
                    ),

                    // Right Arm (Namaste or resting/dancing)
                    Positioned(
                      right: -12,
                      top: 55,
                      child: Transform.rotate(
                        angle: _robotActivity == 1
                            ? -0.9 // Namaste
                            : (_robotActivity == 0
                                ? 0.3 // Rest
                                : 0.3 - (_danceAnimation.value * 2)), // Dance
                        alignment: Alignment.topLeft,
                        child: Container(
                          width: 20,
                          height: 7,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(3.5),
                            border: Border.all(color: Colors.black, width: 1.5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                
                // Status Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                  decoration: BoxDecoration(
                    color: _robotActivity == 1
                        ? const Color(0xFFC3F3C0)
                        : (_robotActivity == 0
                            ? const Color(0xFFC2F3F8)
                            : const Color(0xFFE5D5FF)),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black, width: 1.5),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                  child: Text(
                    _robotActivity == 1
                        ? 'Namaste! 🙏'
                        : (_robotActivity == 0
                            ? 'Hello! 👋'
                            : 'Dancing! 🕺'),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 9,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
