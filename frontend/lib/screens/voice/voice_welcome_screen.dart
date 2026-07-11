import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../widgets/buttons.dart';

import 'dart:async';
import 'dart:math' as math;

enum RobotTrigger {
  pointToSuggestions,
  startVoiceConversation,
}

enum RobotState {
  idle,
  greeting,
  talking,
  dancing,
  thinking,
  pointing,
  heart,
  actionTransition,
}

enum EyeExpression {
  normal,
  smile,
  excited,
  thinking,
  wink,
}

class VoiceWelcomeScreen extends StatefulWidget {
  const VoiceWelcomeScreen({super.key});

  @override
  State<VoiceWelcomeScreen> createState() => _VoiceWelcomeScreenState();
}

class _VoiceWelcomeScreenState extends State<VoiceWelcomeScreen> {
  final ValueNotifier<RobotTrigger?> _robotTriggerNotifier = ValueNotifier<RobotTrigger?>(null);

  void _onSuggestionTap(String suggestion) {
    _robotTriggerNotifier.value = RobotTrigger.pointToSuggestions;
    // Delayed navigation to show the microinteraction of the robot pointing/looking at the suggestion
    Future.delayed(const Duration(milliseconds: 900), () {
      if (mounted) {
        context.push('/voice-standby');
      }
    });
  }

  void _onStartVoiceTap() {
    _robotTriggerNotifier.value = RobotTrigger.startVoiceConversation;
    // Delayed navigation to allow robot to smile, raise hand, wave once, and glow
    Future.delayed(const Duration(milliseconds: 1400), () {
      if (mounted) {
        context.push('/voice-standby');
      }
    });
  }

  @override
  void dispose() {
    _robotTriggerNotifier.dispose();
    super.dispose();
  }

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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    // Live Animated Robot Section
                    SizedBox(
                      width: 140,
                      height: 180,
                      child: AnimatedRobot(triggerNotifier: _robotTriggerNotifier),
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
                        icon: Icons.medication_outlined,
                        color: const Color(0xFFC2F3F8), // Cyan
                        title: 'Explain my medicines',
                        onTap: () => _onSuggestionTap('Explain my medicines'),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      _buildSuggestionCard(
                        icon: Icons.description_outlined,
                        color: const Color(0xFFFED782), // Yellow
                        title: 'Summarize my latest report',
                        onTap: () => _onSuggestionTap('Summarize my latest report'),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      _buildSuggestionCard(
                        icon: Icons.trending_up_outlined,
                        color: const Color(0xFFC3F3C0), // Green
                        title: 'Show my health timeline',
                        onTap: () => _onSuggestionTap('Show my health timeline'),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      _buildSuggestionCard(
                        icon: Icons.science_outlined,
                        color: const Color(0xFFE5D5FF), // Lilac
                        title: 'Explain my latest prescription',
                        onTap: () => _onSuggestionTap('Explain my latest prescription'),
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
                      onPressed: _onStartVoiceTap,
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

  Widget _buildSuggestionCard({
    required IconData icon,
    required Color color,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
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

// ------------------------------------------------------------
// SPEECH BUBBLE PAINTER
// ------------------------------------------------------------
class SpeechBubblePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
      
    final borderPaint = Paint()
      ..color = const Color(0xFF00E5FF).withAlpha(150)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final path = Path()
      ..moveTo(10, 0)
      ..lineTo(size.width - 10, 0)
      ..quadraticBezierTo(size.width, 0, size.width, 10)
      ..lineTo(size.width, size.height - 18)
      ..quadraticBezierTo(size.width, size.height - 10, size.width - 10, size.height - 10)
      // Triangle tail pointing left-down towards robot head
      ..lineTo(size.width * 0.40, size.height - 10)
      ..lineTo(size.width * 0.20, size.height)
      ..lineTo(size.width * 0.30, size.height - 10)
      ..lineTo(10, size.height - 10)
      ..quadraticBezierTo(0, size.height - 10, 0, size.height - 18)
      ..lineTo(0, 10)
      ..quadraticBezierTo(0, 0, 10, 0)
      ..close();

    canvas.drawShadow(path, Colors.black.withAlpha(20), 4.0, true);
    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ------------------------------------------------------------
// ANIMATED ROBOT WITH COMPREHENSIVE ACTIONS
// ------------------------------------------------------------
class AnimatedRobot extends StatefulWidget {
  final ValueNotifier<RobotTrigger?> triggerNotifier;

  const AnimatedRobot({
    super.key,
    required this.triggerNotifier,
  });

  @override
  State<AnimatedRobot> createState() => _AnimatedRobotState();
}

class _AnimatedRobotState extends State<AnimatedRobot> with TickerProviderStateMixin {
  // Animation controllers for various parts
  late final AnimationController _hoverController;
  late final AnimationController _waveController;
  late final AnimationController _danceController;
  late final AnimationController _blinkController;
  late final AnimationController _pulseController;

  late final Animation<double> _hoverAnimation;
  late final Animation<double> _waveAnimation;
  late final Animation<double> _danceAnimation;
  late final Animation<double> _pulseAnimation;

  // Robot States
  RobotState _currentState = RobotState.greeting;
  EyeExpression _eyeExpression = EyeExpression.normal;
  bool _isBlinking = false;
  bool _glowExtra = false;

  // Speech bubble variables
  String _bubbleText = "Namaste! 🙏";
  Timer? _activityTimer;
  Timer? _blinkTimer;

  // List of speech bubble messages to rotate randomly in idle/talking states
  final List<String> _idleMessages = [
    "😊 Welcome back!",
    "💙 I'm here for you.",
    "💊 Need help with medicines?",
    "📄 Upload your report.",
    "🎤 Let's talk!",
    "❤️ Stay healthy!",
    "🩺 How are you feeling today?",
    "✨ Ask me anything!",
  ];

  @override
  void initState() {
    super.initState();

    // 1. Idle Floating Animation (hover)
    _hoverController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _hoverAnimation = Tween<double>(begin: 0.0, end: -6.0).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeInOut),
    );
    _hoverController.repeat(reverse: true);

    // 2. Arm Waving Animation
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _waveAnimation = Tween<double>(begin: -0.2, end: 0.8).animate(
      CurvedAnimation(parent: _waveController, curve: Curves.easeInOut),
    );

    // 3. Torso Dancing Tilt Animation
    _danceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _danceAnimation = Tween<double>(begin: -0.15, end: 0.15).animate(
      CurvedAnimation(parent: _danceController, curve: Curves.easeInOut),
    );

    // 4. Eye Blink Animation
    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );

    // 5. Chest pulse glow animation
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _pulseAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _pulseController.repeat(reverse: true);

    // Setup periodic blink timer (blinks every 4 seconds)
    _blinkTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (mounted && _currentState != RobotState.actionTransition) {
        setState(() => _isBlinking = true);
        _blinkController.forward().then((_) {
          _blinkController.reverse().then((_) {
            if (mounted) {
              setState(() => _isBlinking = false);
            }
          });
        });
      }
    });

    // Listen to parent triggers
    widget.triggerNotifier.addListener(_handleTrigger);

    // Run Greeting sequence on start
    _runGreetingSequence();
  }

  @override
  void dispose() {
    widget.triggerNotifier.removeListener(_handleTrigger);
    _hoverController.dispose();
    _waveController.dispose();
    _danceController.dispose();
    _blinkController.dispose();
    _pulseController.dispose();
    _activityTimer?.cancel();
    _blinkTimer?.cancel();
    super.dispose();
  }

  // ------------------------------------------------------------
  // MICROINTERACTION TRIGGERS FROM PARENT
  // ------------------------------------------------------------
  void _handleTrigger() {
    final trigger = widget.triggerNotifier.value;
    if (trigger == null) return;

    _activityTimer?.cancel();
    _waveController.stop();
    _danceController.stop();

    if (trigger == RobotTrigger.pointToSuggestions) {
      // Point activity
      setState(() {
        _currentState = RobotState.pointing;
        _eyeExpression = EyeExpression.wink;
        _bubbleText = "You can try any of these! 👉";
      });
      // Lift arm to point at suggestions (pointing left in row)
      _waveController.animateTo(0.9, duration: const Duration(milliseconds: 250));
      
      // Return to idle after 1.5 seconds
      _activityTimer = Timer(const Duration(milliseconds: 1500), _returnToIdle);
    } 
    else if (trigger == RobotTrigger.startVoiceConversation) {
      // Action transition activity
      setState(() {
        _currentState = RobotState.actionTransition;
        _eyeExpression = EyeExpression.excited;
        _bubbleText = "Let's talk! 🎤";
        _glowExtra = true;
      });
      // Fast happy arm wave once
      _waveController.repeat(reverse: true, period: const Duration(milliseconds: 200));
    }

    // Reset trigger
    widget.triggerNotifier.value = null;
  }

  // ------------------------------------------------------------
  // GREETING TIMELINE SEQUENCE (On Load)
  // ------------------------------------------------------------
  Future<void> _runGreetingSequence() async {
    // Stage 1: Wave and say Namaste!
    setState(() {
      _currentState = RobotState.greeting;
      _eyeExpression = EyeExpression.smile;
      _bubbleText = "Namaste! 🙏";
    });
    _waveController.repeat(reverse: true);

    await Future.delayed(const Duration(milliseconds: 2000));
    if (!mounted || _currentState == RobotState.actionTransition) return;

    // Stage 2: Hand on chest and say Hello John!
    setState(() {
      _eyeExpression = EyeExpression.normal;
      _bubbleText = "Hello John! 👋";
    });
    // Lift arm halfway (simulating chest hold)
    _waveController.animateTo(0.3, duration: const Duration(milliseconds: 300));

    await Future.delayed(const Duration(milliseconds: 2000));
    if (!mounted || _currentState == RobotState.actionTransition) return;

    // Stage 3: Welcome message
    setState(() {
      _eyeExpression = EyeExpression.smile;
      _bubbleText = "I'm NURA, your AI Health Copilot!";
    });

    await Future.delayed(const Duration(milliseconds: 2500));
    _returnToIdle();
  }

  // ------------------------------------------------------------
  // IDLE & RANDOM ACTIVITIES LOOP
  // ------------------------------------------------------------
  void _returnToIdle() {
    if (!mounted || _currentState == RobotState.actionTransition) return;

    setState(() {
      _currentState = RobotState.idle;
      _eyeExpression = EyeExpression.normal;
      // Get a random message from the idle list
      _bubbleText = _idleMessages[math.Random().nextInt(_idleMessages.length)];
    });

    _waveController.stop();
    _danceController.stop();

    // Schedule next random activity in 5-6 seconds
    _activityTimer = Timer(Duration(seconds: 4 + math.Random().nextInt(3)), _triggerRandomActivity);
  }

  void _triggerRandomActivity() {
    if (!mounted || _currentState == RobotState.actionTransition) return;

    final random = math.Random();
    final choice = random.nextInt(6); // 6 different short activities

    switch (choice) {
      case 0: // Waving Hello
        setState(() {
          _currentState = RobotState.talking;
          _eyeExpression = EyeExpression.smile;
          _bubbleText = "Hello! 👋 How are you?";
        });
        _waveController.repeat(reverse: true);
        break;

      case 1: // Namaste Jump
        setState(() {
          _currentState = RobotState.heart; // Represents folding/Namaste
          _eyeExpression = EyeExpression.smile;
          _bubbleText = "Namaste! 🙏";
        });
        // Both arms fold up
        _waveController.animateTo(0.8, duration: const Duration(milliseconds: 300));
        // Bounce jump
        _hoverController.duration = const Duration(milliseconds: 250);
        _hoverController.forward().then((_) => _hoverController.reverse().then((_) {
          _hoverController.duration = const Duration(milliseconds: 2000);
          _hoverController.repeat(reverse: true);
        }));
        break;

      case 2: // Happy Dance
        setState(() {
          _currentState = RobotState.dancing;
          _eyeExpression = EyeExpression.excited;
          _bubbleText = "Let's take care of your health! 💚";
        });
        _danceController.repeat(reverse: true);
        _waveController.repeat(reverse: true, period: const Duration(milliseconds: 500));
        break;

      case 3: // Thinking
        setState(() {
          _currentState = RobotState.thinking;
          _eyeExpression = EyeExpression.thinking;
          _bubbleText = "Let me check that for you... 🤔";
        });
        // Hand on chin
        _waveController.animateTo(0.6, duration: const Duration(milliseconds: 350));
        break;

      case 4: // Heart/Caring pose
        setState(() {
          _currentState = RobotState.heart;
          _eyeExpression = EyeExpression.excited;
          _bubbleText = "I'm always here for you! 💙";
        });
        _waveController.animateTo(0.7, duration: const Duration(milliseconds: 300));
        break;

      case 5: // Pointing
        setState(() {
          _currentState = RobotState.pointing;
          _eyeExpression = EyeExpression.wink;
          _bubbleText = "You can ask me anything! ✨";
        });
        _waveController.animateTo(0.9, duration: const Duration(milliseconds: 250));
        break;
    }

    // Run activity for 3 seconds then return to idle
    _activityTimer = Timer(const Duration(seconds: 3), _returnToIdle);
  }

  // ------------------------------------------------------------
  // CUSTOM EYE RENDER PIECES
  // ------------------------------------------------------------
  Widget _buildEyes() {
    if (_isBlinking) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(width: 8, height: 2, color: const Color(0xFF00E5FF)),
          const SizedBox(width: 10),
          Container(width: 8, height: 2, color: const Color(0xFF00E5FF)),
        ],
      );
    }

    switch (_eyeExpression) {
      case EyeExpression.smile:
      case EyeExpression.excited:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _smileEye(),
            const SizedBox(width: 8),
            _smileEye(),
          ],
        );
      case EyeExpression.thinking:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _circularEye(),
            const SizedBox(width: 8),
            Transform.translate(
              offset: const Offset(0, -2),
              child: _circularEye(size: 6),
            ),
          ],
        );
      case EyeExpression.wink:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _circularEye(),
            const SizedBox(width: 8),
            Container(width: 8, height: 2, color: const Color(0xFF00E5FF)),
          ],
        );
      case EyeExpression.normal:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _circularEye(),
            const SizedBox(width: 8),
            _circularEye(),
          ],
        );
    }
  }

  Widget _circularEye({double size = 8}) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Color(0xFF00E5FF),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: Color(0xFF00E5FF), blurRadius: 4),
        ],
      ),
    );
  }

  Widget _smileEye() {
    return Container(
      width: 10,
      height: 8,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: const Color(0xFF00E5FF), width: 2.2),
          left: BorderSide(color: const Color(0xFF00E5FF), width: 2.2),
          right: BorderSide(color: const Color(0xFF00E5FF), width: 2.2),
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // MAIN RENDER METHOD
  // ------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _hoverController,
        _waveController,
        _danceController,
        _pulseController,
      ]),
      builder: (context, child) {
        double yOffset = _hoverAnimation.value;
        double tiltAngle = 0.0;
        double robotScale = 1.0;

        if (_currentState == RobotState.dancing) {
          tiltAngle = _danceAnimation.value;
        } else if (_currentState == RobotState.actionTransition) {
          robotScale = 1.05; // Slightly expand on voice start tap
        }

        return Column(
          children: [
            // Speech Bubble with Fade / Scale Switcher Animation
            SizedBox(
              height: 58,
              width: 135,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(
                      scale: Tween<double>(begin: 0.85, end: 1.0).animate(
                        CurvedAnimation(parent: animation, curve: Curves.easeOut),
                      ),
                      child: child,
                    ),
                  );
                },
                child: CustomPaint(
                  key: ValueKey<String>(_bubbleText),
                  painter: SpeechBubblePainter(),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(8, 6, 8, 14),
                    alignment: Alignment.center,
                    child: Text(
                      _bubbleText,
                      style: const TextStyle(
                        color: Color(0xFF1E244A),
                        fontWeight: FontWeight.w800,
                        fontSize: 10,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 2),

            // Robot Body
            Transform.translate(
              offset: Offset(0, yOffset),
              child: Transform.rotate(
                angle: tiltAngle,
                child: Transform.scale(
                  scale: robotScale,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    clipBehavior: Clip.none,
                    children: [
                      // Aura Glow background
                      Positioned(
                        top: 15,
                        child: Container(
                          width: _glowExtra ? 95 : 85,
                          height: _glowExtra ? 95 : 85,
                          decoration: BoxDecoration(
                            color: _glowExtra 
                                ? const Color(0xFF00E5FF).withAlpha(30)
                                : const Color(0xFF00E5FF).withAlpha(12),
                            shape: BoxShape.circle,
                            boxShadow: _glowExtra
                                ? const [BoxShadow(color: Color(0xFF00E5FF), blurRadius: 15, spreadRadius: 4)]
                                : null,
                          ),
                        ),
                      ),

                      // Main body stack (Head, neck, body, legs)
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
                                  width: 4,
                                  height: 10,
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
                                  width: 4,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF00E5FF),
                                    borderRadius: BorderRadius.circular(2),
                                    border: Border.all(color: Colors.black, width: 1.2),
                                  ),
                                ),
                              ),
                              // Head Shell
                              Container(
                                width: 50,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(color: Colors.black, width: 1.8),
                                ),
                                child: Center(
                                  child: Container(
                                    width: 40,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF1E1E2C),
                                      borderRadius: BorderRadius.circular(9),
                                    ),
                                    child: Center(
                                      child: _buildEyes(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          // Neck Link
                          Container(
                            width: 6,
                            height: 3,
                            color: Colors.black,
                          ),
                          
                          // Torso / Chest with Pulse Indicator
                          Container(
                            width: 42,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black, width: 1.8),
                            ),
                            child: Center(
                              child: Opacity(
                                opacity: _pulseAnimation.value,
                                child: Container(
                                  width: 14,
                                  height: 14,
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
                                  child: const Center(
                                    child: Icon(
                                      Icons.favorite,
                                      color: Colors.white,
                                      size: 8,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          
                          // Legs link
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(width: 4, height: 8, color: Colors.black),
                              const SizedBox(width: 12),
                              Container(width: 4, height: 8, color: Colors.black),
                            ],
                          ),
                          
                          // Feet
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 10,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(2.5),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                width: 10,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(2.5),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Left Arm (Namaste folded or waving hello)
                      Positioned(
                        left: -10,
                        top: 50,
                        child: Transform.rotate(
                          angle: _currentState == RobotState.heart
                              ? 0.9 // Folded in Namaste
                              : (_currentState == RobotState.greeting || _currentState == RobotState.talking || _currentState == RobotState.actionTransition
                                  ? _waveAnimation.value // Active Waving
                                  : (_currentState == RobotState.dancing
                                      ? -0.3 + (_danceAnimation.value * 2) // Dance move
                                      : -0.2)), // Resting idle
                          alignment: Alignment.topRight,
                          child: Container(
                            width: 18,
                            height: 6,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(3),
                              border: Border.all(color: Colors.black, width: 1.5),
                            ),
                          ),
                        ),
                      ),

                      // Right Arm (Namaste folded, pointing, or resting)
                      Positioned(
                        right: -10,
                        top: 50,
                        child: Transform.rotate(
                          angle: _currentState == RobotState.heart
                              ? -0.9 // Folded in Namaste
                              : (_currentState == RobotState.pointing
                                  ? -1.2 // Pointing left at cards
                                  : (_currentState == RobotState.thinking
                                      ? -0.8 // Touching chin
                                      : (_currentState == RobotState.dancing
                                          ? 0.3 - (_danceAnimation.value * 2) // Dance move
                                          : 0.2))), // Resting idle
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: 18,
                            height: 6,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(3),
                              border: Border.all(color: Colors.black, width: 1.5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
