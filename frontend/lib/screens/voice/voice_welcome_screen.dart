import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../widgets/buttons.dart';
import '../../features/auth/providers/auth_state_provider.dart';

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

class VoiceWelcomeScreen extends ConsumerStatefulWidget {
  const VoiceWelcomeScreen({super.key});

  @override
  ConsumerState<VoiceWelcomeScreen> createState() => _VoiceWelcomeScreenState();
}

class _VoiceWelcomeScreenState extends ConsumerState<VoiceWelcomeScreen> {
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0A0C16) : null,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: isDark
              ? const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF0A0C16),
                    Color(0xFF13172E),
                    Color(0xFF0A0C16),
                  ],
                )
              : const LinearGradient(
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
                            'Hello ${ref.watch(authStateProvider).user?.name.split(' ').first ?? 'John'} 👋',
                            style: AppTypography.bodyLarge.copyWith(
                              color: isDark ? Colors.white70 : Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "I'm NURA",
                            style: TextStyle(
                              color: isDark ? Colors.white : const Color(0xFF1E244A),
                              fontWeight: FontWeight.w900,
                              fontSize: 32,
                              letterSpacing: 0.5,
                            ),
                          ),
                          Text(
                            "Your AI Health Copilot",
                            style: TextStyle(
                              color: isDark ? const Color(0xFF81C784) : const Color(0xFF2E7D32),
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
                Text(
                  "I understand your medicines, reports, symptoms and health history. How can I help you today?",
                  style: TextStyle(
                    color: isDark ? Colors.white70 : Colors.black87,
                    fontSize: 14,
                    height: 1.4,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                
                const SizedBox(height: AppSpacing.md),
                
                // Suggestions Section
                Text(
                  'Quick Suggestions',
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black87,
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
                        onTap: () => _onSuggestionTap('Explain my medicines'),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      _buildSuggestionCard(
                        context,
                        icon: Icons.description_outlined,
                        color: const Color(0xFFFED782), // Yellow
                        title: 'Summarize my latest report',
                        onTap: () => _onSuggestionTap('Summarize my latest report'),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      _buildSuggestionCard(
                        context,
                        icon: Icons.trending_up_outlined,
                        color: const Color(0xFFC3F3C0), // Green
                        title: 'Show my health timeline',
                        onTap: () => _onSuggestionTap('Show my health timeline'),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      _buildSuggestionCard(
                        context,
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
                      color: isDark ? Colors.white : Colors.black,
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
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF121625) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isDark ? Colors.white24 : Colors.black, width: 1.8),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.white10 : Colors.black,
              offset: const Offset(2, 4),
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
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: isDark ? Colors.white60 : Colors.black54, size: 16),
          ],
        ),
      ),
    );
  }
}

// ------------------------------------------------------------
// SPEECH BUBBLE PAINTER (Premium Neobrutalist Glass-style)
// ------------------------------------------------------------
class SpeechBubblePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
      
    final borderPaint = Paint()
      ..color = const Color(0xFF00E5FF).withValues(alpha: 0.45)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;

    final path = Path()
      ..moveTo(12, 0)
      ..lineTo(size.width - 12, 0)
      ..quadraticBezierTo(size.width, 0, size.width, 12)
      ..lineTo(size.width, size.height - 18)
      ..quadraticBezierTo(size.width, size.height - 10, size.width - 12, size.height - 10)
      // Triangle tail pointing down towards the robot head
      ..lineTo(size.width * 0.45, size.height - 10)
      ..lineTo(size.width * 0.25, size.height - 1)
      ..lineTo(size.width * 0.32, size.height - 10)
      ..lineTo(12, size.height - 10)
      ..quadraticBezierTo(0, size.height - 10, 0, size.height - 18)
      ..lineTo(0, 12)
      ..quadraticBezierTo(0, 0, 12, 0)
      ..close();

    // Outer premium soft shadow
    canvas.drawShadow(path, const Color(0xFF00E5FF).withValues(alpha: 0.18), 6.0, false);
    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ------------------------------------------------------------
// ANIMATED ROBOT WITH COMPREHENSIVE ACTIONS (Natural behavior loop)
// ------------------------------------------------------------
class AnimatedRobot extends ConsumerStatefulWidget {
  final ValueNotifier<RobotTrigger?> triggerNotifier;

  const AnimatedRobot({
    super.key,
    required this.triggerNotifier,
  });

  @override
  ConsumerState<AnimatedRobot> createState() => _AnimatedRobotState();
}

class _AnimatedRobotState extends ConsumerState<AnimatedRobot> with TickerProviderStateMixin {
  // Animation controllers for premium 3D movement and core glow
  late final AnimationController _hoverController;
  late final AnimationController _pulseController;
  late final AnimationController _blinkController;

  late final Animation<double> _hoverAnimation;
  late final Animation<double> _pulseAnimation;

  // Active state parameters driven by state machine with automatic TweenAnimationBuilder transitions
  RobotState _currentState = RobotState.greeting;
  EyeExpression _eyeExpression = EyeExpression.normal;
  bool _glowExtra = false;
  int _messageIndex = 0;
  int _lastActionIndex = -1;

  // Physical target values for custom painter inputs
  double _rightArmAngle = 0.2;
  double _leftArmAngle = -0.2;
  double _bodyTilt = 0.0;
  double _headTilt = 0.0;
  double _eyeOffsetX = 0.0;
  double _eyeOffsetY = 0.0;
  double _headOffsetY = 0.0;
  double _eyeScale = 1.0;

  // Speech bubble variables
  String _bubbleText = "Namaste! 🙏";
  Timer? _loopTimer;
  Timer? _blinkTimer;
  Timer? _rotationTimer;
  bool _isBlinking = false;
  bool _isBusy = false; // Disables idle randomizer during active greeting or talk states

  // List of speech bubble messages to rotate
  final List<String> _idleMessages = [
    "Hello 👋",
    "Namaste 🙏",
    "Welcome back!",
    "Let's talk 🎤",
    "I'm NURA",
    "I'm your AI Health Copilot",
    "How are you feeling today?",
    "Need help with medicines?",
    "Let's review your health.",
    "Everything looks good today.",
    "You can ask me anything.",
  ];

  @override
  void initState() {
    super.initState();

    // 1. Idle Floating Animation (hover)
    _hoverController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    );
    _hoverAnimation = Tween<double>(begin: 0.0, end: -5.0).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeInOut),
    );
    _hoverController.repeat(reverse: true);

    // 2. Chest pulse glow animation
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _pulseAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _pulseController.repeat(reverse: true);

    // 3. Eye Blink Controller
    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );

    // Setup periodic blink timer (blinks every 3.5 - 5 seconds randomly)
    _startBlinkTimer();

    // Listen to parent triggers
    widget.triggerNotifier.addListener(_handleTrigger);

    // Run Greeting sequence on start
    _runGreetingSequence();
  }

  @override
  void dispose() {
    widget.triggerNotifier.removeListener(_handleTrigger);
    _hoverController.dispose();
    _pulseController.dispose();
    _blinkController.dispose();
    _loopTimer?.cancel();
    _blinkTimer?.cancel();
    _rotationTimer?.cancel();
    super.dispose();
  }

  // ------------------------------------------------------------
  // RANDOM EYE BLINKING
  // ------------------------------------------------------------
  void _startBlinkTimer() {
    _blinkTimer?.cancel();
    final randomSecs = 3 + math.Random().nextInt(3);
    _blinkTimer = Timer(Duration(seconds: randomSecs), () {
      if (mounted && _currentState != RobotState.actionTransition) {
        setState(() => _isBlinking = true);
        _blinkController.forward().then((_) {
          _blinkController.reverse().then((_) {
            if (mounted) {
              setState(() => _isBlinking = false);
              _startBlinkTimer();
            }
          });
        });
      } else {
        _startBlinkTimer();
      }
    });
  }

  // ------------------------------------------------------------
  // MICROINTERACTION TRIGGERS FROM PARENT
  // ------------------------------------------------------------
  void _handleTrigger() {
    final trigger = widget.triggerNotifier.value;
    if (trigger == null) return;

    _loopTimer?.cancel();
    _rotationTimer?.cancel();
    setState(() {
      _isBusy = true;
    });

    if (trigger == RobotTrigger.pointToSuggestions) {
      _currentState = RobotState.pointing;
      _triggerPointingPose();
    } 
    else if (trigger == RobotTrigger.startVoiceConversation) {
      _currentState = RobotState.actionTransition;
      _triggerVoiceConversationPose();
    }

    widget.triggerNotifier.value = null;
  }

  // ------------------------------------------------------------
  // SPECIFIC ACTION POSES
  // ------------------------------------------------------------
  void _triggerPointingPose() {
    setState(() {
      _rightArmAngle = -1.25; // Point left
      _leftArmAngle = -0.2;
      _bodyTilt = -0.05;
      _headTilt = -0.08; // Look left towards cards
      _eyeOffsetX = -2.5; // Pupils look left
      _eyeOffsetY = 0.0;
      _eyeExpression = EyeExpression.wink;
      _bubbleText = "You can ask me anything.";
    });

    // Hold pointing for 1.5 seconds then release back to normal idle loop
    _loopTimer = Timer(const Duration(milliseconds: 1500), () {
      setState(() {
        _isBusy = false;
        _returnToIdlePose();
      });
      _startNaturalLoop();
      _startSpeechRotation();
    });
  }

  void _triggerVoiceConversationPose() {
    setState(() {
      _rightArmAngle = -1.0;
      _leftArmAngle = -0.3;
      _bodyTilt = 0.05;
      _headTilt = 0.05;
      _eyeOffsetX = 0.0;
      _eyeOffsetY = 0.0;
      _eyeExpression = EyeExpression.excited;
      _bubbleText = "Let's talk 🎤";
      _glowExtra = true;
      _eyeScale = 1.25;
    });
    // Wave hand fast
    _animateWave(waves: 4);
  }

  // Helper to execute wave oscillations
  Future<void> _animateWave({required int waves}) async {
    for (int i = 0; i < waves; i++) {
      if (!mounted) break;
      setState(() {
        _rightArmAngle = i % 2 == 0 ? -1.15 : -0.75;
      });
      await Future.delayed(const Duration(milliseconds: 200));
    }
  }

  // Helper to execute clap oscillations
  Future<void> _animateClap({required int claps}) async {
    for (int i = 0; i < claps; i++) {
      if (!mounted) break;
      setState(() {
        _rightArmAngle = i % 2 == 0 ? -0.2 : -0.55;
        _leftArmAngle = i % 2 == 0 ? 0.2 : 0.55;
      });
      await Future.delayed(const Duration(milliseconds: 180));
    }
  }

  // Helper to execute wiggle/dance oscillations
  Future<void> _animateDance({required int steps}) async {
    for (int i = 0; i < steps; i++) {
      if (!mounted) break;
      setState(() {
        _bodyTilt = i % 2 == 0 ? 0.12 : -0.12;
        _rightArmAngle = i % 2 == 0 ? 0.35 : -0.35;
        _leftArmAngle = i % 2 == 0 ? -0.35 : 0.35;
      });
      await Future.delayed(const Duration(milliseconds: 250));
    }
  }

  // ------------------------------------------------------------
  // GREETING SEQUENCE (On Screen Load)
  // ------------------------------------------------------------
  Future<void> _runGreetingSequence() async {
    setState(() {
      _isBusy = true;
      _currentState = RobotState.greeting;
      _eyeExpression = EyeExpression.smile;
      _bubbleText = "Namaste 🙏";
    });
    
    // Wave hand naturally on entry
    await _animateWave(waves: 5);
    if (!mounted || _currentState == RobotState.actionTransition) return;

    // Small bow & Hello
    final firstName = ref.read(authStateProvider).user?.name.split(' ').first ?? 'John';
    setState(() {
      _eyeExpression = EyeExpression.normal;
      _bubbleText = "Hello $firstName 👋";
      _headOffsetY = 2.0; // Bow head
      _headTilt = 0.08;
      _rightArmAngle = -0.3; // Hand on chest
      _leftArmAngle = -0.2;
    });

    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted || _currentState == RobotState.actionTransition) return;

    // I'm NURA
    setState(() {
      _headOffsetY = 0.0;
      _headTilt = 0.0;
      _eyeExpression = EyeExpression.smile;
      _bubbleText = "I'm NURA";
      _rightArmAngle = 0.2;
    });

    await Future.delayed(const Duration(milliseconds: 1600));
    if (!mounted || _currentState == RobotState.actionTransition) return;

    setState(() {
      _isBusy = false;
    });
    _startNaturalLoop();
    _startSpeechRotation();
  }

  void _startSpeechRotation() {
    _rotationTimer?.cancel();
    _rotationTimer = Timer.periodic(const Duration(milliseconds: 5500), (timer) {
      if (!mounted || _currentState == RobotState.actionTransition || _isBusy) return;

      _messageIndex = (_messageIndex + 1) % _idleMessages.length;
      final newMessage = _idleMessages[_messageIndex];
      setState(() {
        _bubbleText = newMessage;
      });
      _onMessageChanged(newMessage);
    });
  }

  // ------------------------------------------------------------
  // NATURAL BEHAVIOR LOOP (Duolingo-like randomized flow)
  // ------------------------------------------------------------
  void _startNaturalLoop() {
    _loopTimer?.cancel();

    // Random timing: pause between animations (3 to 6 seconds)
    final randomSecs = 3.0 + (math.Random().nextDouble() * 3.0);
    _loopTimer = Timer(Duration(milliseconds: (randomSecs * 1000).toInt()), () {
      if (!mounted || _currentState == RobotState.actionTransition || _isBusy) return;

      _executeRandomAction();
    });
  }

  Future<void> _executeRandomAction() async {
    if (!mounted || _currentState == RobotState.actionTransition || _isBusy) return;

    final random = math.Random();
    
    // Define 10 distinct personality actions
    // Ensure we do not pick the same action twice consecutively
    int actionIndex;
    do {
      actionIndex = random.nextInt(10);
    } while (actionIndex == _lastActionIndex);
    _lastActionIndex = actionIndex;

    setState(() {
      _isBusy = true;
    });

    switch (actionIndex) {
      case 0: // 👀 Look Left
        setState(() {
          _eyeOffsetX = -2.5;
          _headTilt = -0.08;
          _rightArmAngle = 0.3;
        });
        await Future.delayed(const Duration(milliseconds: 1500));
        break;

      case 1: // 👀 Look Right
        setState(() {
          _eyeOffsetX = 2.5;
          _headTilt = 0.08;
          _leftArmAngle = -0.3;
        });
        await Future.delayed(const Duration(milliseconds: 1500));
        break;

      case 2: // 😉 Blink & Wink
        setState(() {
          _eyeExpression = EyeExpression.wink;
          _headTilt = 0.06;
        });
        await Future.delayed(const Duration(milliseconds: 1200));
        break;

      case 3: // 🤖 Head Tilt
        setState(() {
          _headTilt = -0.15;
          _eyeOffsetY = -1.0;
        });
        await Future.delayed(const Duration(milliseconds: 1400));
        break;

      case 4: // 👋 Small Wave
        setState(() {
          _eyeExpression = EyeExpression.smile;
        });
        await _animateWave(waves: 4);
        break;

      case 5: // ✨ Tiny Jump & Celebration
        setState(() {
          _eyeExpression = EyeExpression.excited;
          _headOffsetY = -5.0; // Leap
        });
        await Future.delayed(const Duration(milliseconds: 250));
        setState(() {
          _headOffsetY = 2.0; // Landing squash
        });
        await Future.delayed(const Duration(milliseconds: 200));
        setState(() {
          _headOffsetY = 0.0; // Stabilize
        });
        break;

      case 6: // 💃 Happy Dance (2 seconds)
        setState(() {
          _eyeExpression = EyeExpression.excited;
        });
        await _animateDance(steps: 6);
        break;

      case 7: // 🫶 Namaste
        setState(() {
          _eyeExpression = EyeExpression.smile;
          _rightArmAngle = -0.85;
          _leftArmAngle = 0.85;
        });
        await Future.delayed(const Duration(milliseconds: 1600));
        break;

      case 8: // 🤔 Think / Ponder
        setState(() {
          _eyeExpression = EyeExpression.thinking;
          _rightArmAngle = -0.85; // chin touch
          _eyeOffsetY = -2.0; // look up
          _headTilt = 0.1;
        });
        await Future.delayed(const Duration(milliseconds: 1800));
        break;

      case 9: // 👏 Clap
        setState(() {
          _eyeExpression = EyeExpression.smile;
        });
        await _animateClap(claps: 5);
        break;
    }

    if (!mounted || _currentState == RobotState.actionTransition) return;

    // Return to natural idle and start the timer for the next action
    setState(() {
      _returnToIdlePose();
      _isBusy = false;
    });

    _startNaturalLoop();
  }

  void _returnToIdlePose() {
    _rightArmAngle = 0.2;
    _leftArmAngle = -0.2;
    _bodyTilt = 0.0;
    _headTilt = 0.0;
    _eyeOffsetX = 0.0;
    _eyeOffsetY = 0.0;
    _headOffsetY = 0.0;
    _eyeScale = 1.0;
    _eyeExpression = EyeExpression.normal;
    _glowExtra = false;
  }

  // ------------------------------------------------------------
  // RESPONSE TO SPEECH BUBBLE CHANGE
  // ------------------------------------------------------------
  void _onMessageChanged(String message) {
    if (!mounted || _currentState == RobotState.actionTransition || widget.triggerNotifier.value != null) return;

    // Cancel current idle timer and set busy state
    _loopTimer?.cancel();
    setState(() {
      _isBusy = true;
    });

    // Check if message is health query related to trigger Thinking
    if (message.contains("medicines") || message.contains("health") || message.contains("review")) {
      _executeThinkingSequence();
    } else {
      _executeTalkingSequence();
    }
  }

  Future<void> _executeThinkingSequence() async {
    // 1. Chin touch, eyes look up, tilt head, pause
    setState(() {
      _currentState = RobotState.thinking;
      _eyeExpression = EyeExpression.thinking;
      _rightArmAngle = -0.85; // Chin touch
      _leftArmAngle = -0.1;
      _headTilt = 0.12;
      _eyeOffsetX = 0.0;
      _eyeOffsetY = -2.0; // Pupils up
      _eyeScale = 0.95;
    });

    await Future.delayed(const Duration(milliseconds: 1800));
    if (!mounted || _currentState == RobotState.actionTransition) return;

    // 2. Smile, resolve thinking pose
    setState(() {
      _eyeExpression = EyeExpression.smile;
      _eyeOffsetY = 0.0;
      _eyeScale = 1.1;
    });

    await Future.delayed(const Duration(milliseconds: 800));
    _completeSpeechActivity();
  }

  Future<void> _executeTalkingSequence() async {
    // Lean forward slightly, nod head, eyes brighten, move one hand naturally
    setState(() {
      _currentState = RobotState.talking;
      _eyeExpression = EyeExpression.normal;
      _headOffsetY = 2.0; // Lean forward
      _eyeScale = 1.15; // Brighten eyes
      _glowExtra = true;
      _rightArmAngle = -0.35; // Move arm slightly up
    });

    // Quick nod oscillation
    for (int i = 0; i < 3; i++) {
      if (!mounted || _currentState == RobotState.actionTransition) return;
      setState(() {
        _headTilt = i % 2 == 0 ? 0.06 : -0.03;
      });
      await Future.delayed(const Duration(milliseconds: 350));
    }

    _completeSpeechActivity();
  }

  void _completeSpeechActivity() {
    if (!mounted || _currentState == RobotState.actionTransition) return;

    final random = math.Random();
    
    // 35% chance to perform a quick happy celebration after talking
    if (random.nextDouble() < 0.35) {
      _executeHappyCelebration();
    } else {
      setState(() {
        _returnToIdlePose();
        _isBusy = false;
      });
      _startNaturalLoop();
    }
  }

  Future<void> _executeHappyCelebration() async {
    final random = math.Random().nextInt(3);

    if (random == 0) { // Wiggle
      await _animateDance(steps: 4);
    } else if (random == 1) { // Quick bounce jump
      setState(() {
        _eyeExpression = EyeExpression.excited;
        _headOffsetY = -4.0;
      });
      await Future.delayed(const Duration(milliseconds: 200));
      setState(() {
        _headOffsetY = 1.5;
      });
      await Future.delayed(const Duration(milliseconds: 150));
    } else { // Clap
      await _animateClap(claps: 4);
    }

    if (!mounted || _currentState == RobotState.actionTransition) return;

    setState(() {
      _returnToIdlePose();
      _isBusy = false;
    });
    _startNaturalLoop();
  }

  // ------------------------------------------------------------
  // RENDER INTERACTION
  // ------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // Intercept when parent passes a new message during build
    return Column(
      children: [
        // Premium Speech Bubble
        SizedBox(
          height: 58,
          width: 135,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
              return Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  ...previousChildren,
                  if (currentChild != null) currentChild,
                ],
              );
            },
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.88, end: 1.0).animate(
                    CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
                  ),
                  child: child,
                ),
              );
            },
            child: CustomPaint(
              key: ValueKey<String>(_bubbleText),
              painter: SpeechBubblePainter(),
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 16),
                alignment: Alignment.center,
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 200),
                  builder: (context, val, child) {
                    return Opacity(opacity: val, child: child);
                  },
                  child: Text(
                    _bubbleText,
                    style: const TextStyle(
                      color: Color(0xFF1E244A),
                      fontWeight: FontWeight.w800,
                      fontSize: 10,
                      height: 1.25,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),

        // Premium Redesigned 3D-shaded Robot Canvas using TweenAnimationBuilders
        SizedBox(
          width: 140,
          height: 118,
          child: AnimatedBuilder(
            animation: _hoverController,
            builder: (context, child) {
              final double hoverVal = _hoverAnimation.value;

              // Animate physics values smoothly to avoid robotic jumps
              return TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.2, end: _rightArmAngle),
                duration: const Duration(milliseconds: 320),
                curve: Curves.easeOutBack,
                builder: (context, rightArmVal, child) {
                  return TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: -0.2, end: _leftArmAngle),
                    duration: const Duration(milliseconds: 320),
                    curve: Curves.easeOutBack,
                    builder: (context, leftArmVal, child) {
                      return TweenAnimationBuilder<double>(
                        tween: Tween<double>(begin: 0.0, end: _bodyTilt),
                        duration: const Duration(milliseconds: 380),
                        curve: Curves.easeInOut,
                        builder: (context, bodyTiltVal, child) {
                          return TweenAnimationBuilder<double>(
                            tween: Tween<double>(begin: 0.0, end: _headTilt),
                            duration: const Duration(milliseconds: 280),
                            curve: Curves.easeOut,
                            builder: (context, headTiltVal, child) {
                              return TweenAnimationBuilder<double>(
                                tween: Tween<double>(begin: 0.0, end: _eyeOffsetX),
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeOut,
                                builder: (context, eyeOffsetXVal, child) {
                                  return TweenAnimationBuilder<double>(
                                    tween: Tween<double>(begin: 0.0, end: _eyeOffsetY),
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeOut,
                                    builder: (context, eyeOffsetYVal, child) {
                                      return TweenAnimationBuilder<double>(
                                        tween: Tween<double>(begin: 0.0, end: _headOffsetY),
                                        duration: const Duration(milliseconds: 280),
                                        curve: Curves.easeInOut,
                                        builder: (context, headOffsetYVal, child) {
                                          return TweenAnimationBuilder<double>(
                                            tween: Tween<double>(begin: 1.0, end: _eyeScale),
                                            duration: const Duration(milliseconds: 250),
                                            curve: Curves.easeOut,
                                            builder: (context, eyeScaleVal, child) {
                                              return CustomPaint(
                                                painter: PremiumRobotPainter(
                                                  hoverOffset: hoverVal,
                                                  bodyTilt: bodyTiltVal,
                                                  headTilt: headTiltVal,
                                                  rightArmAngle: rightArmVal,
                                                  leftArmAngle: leftArmVal,
                                                  pulseValue: _pulseAnimation.value,
                                                  blinkValue: _isBlinking ? 0.0 : 1.0,
                                                  eyeExpression: _eyeExpression,
                                                  glowExtra: _glowExtra,
                                                  danceStep: bodyTiltVal,
                                                  eyeOffsetX: eyeOffsetXVal,
                                                  eyeOffsetY: eyeOffsetYVal,
                                                  headOffsetY: headOffsetYVal,
                                                  eyeScale: eyeScaleVal,
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  // Intercepting parent list message change
  @override
  void didUpdateWidget(covariant AnimatedRobot oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Listen to parent text changes to synchronize mouth/gestures
    // This is driven by rotating idleMessages in the welcome screen.
    // To sync text changes from rotation timer to behavior:
    _onMessageChanged(_bubbleText);
  }
}

// ------------------------------------------------------------
// PREMIUM 3D-SHADED VECTOR ROBOT PAINTER (No outlines, smooth glossy texture)
// ------------------------------------------------------------
class PremiumRobotPainter extends CustomPainter {
  final double hoverOffset;
  final double bodyTilt;
  final double headTilt;
  final double rightArmAngle;
  final double leftArmAngle;
  final double pulseValue;
  final double blinkValue;
  final EyeExpression eyeExpression;
  final bool glowExtra;
  final double danceStep;
  final double eyeOffsetX;
  final double eyeOffsetY;
  final double headOffsetY;
  final double eyeScale;

  PremiumRobotPainter({
    required this.hoverOffset,
    required this.bodyTilt,
    required this.headTilt,
    required this.rightArmAngle,
    required this.leftArmAngle,
    required this.pulseValue,
    required this.blinkValue,
    required this.eyeExpression,
    required this.glowExtra,
    required this.danceStep,
    required this.eyeOffsetX,
    required this.eyeOffsetY,
    required this.headOffsetY,
    required this.eyeScale,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double cx = size.width / 2;
    final double baseGy = size.height - 12;

    // 1. Ambient Ground Shadows & Floor Glowing Aura
    final shadowPaint = Paint()
      ..color = const Color(0xFF1E244A).withValues(alpha: 0.12)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx + (danceStep * 6), baseGy + 2), width: 44, height: 6),
      shadowPaint,
    );

    final auraPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF00E5FF).withValues(alpha: glowExtra ? 0.35 : 0.16),
          const Color(0xFF00E5FF).withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromCenter(center: Offset(cx + (danceStep * 6), baseGy), width: 64, height: 12));
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx + (danceStep * 6), baseGy), width: 64, height: 12),
      auraPaint,
    );

    canvas.save();
    
    // Applying Hover/Floating vertical translations
    canvas.translate(0, hoverOffset);

    // Coordinate points setup
    final bodyCenter = Offset(cx, size.height - 48);
    final headCenter = Offset(cx, size.height - 84 + headOffsetY);

    // 2. Draw Legs & Feet (anchored to torso but organically shaded)
    final leftLegStart = Offset(cx - 10, bodyCenter.dy + 12);
    final leftLegEnd = Offset(cx - 11, baseGy - 6);
    final rightLegStart = Offset(cx + 10, bodyCenter.dy + 12);
    final rightLegEnd = Offset(cx + 11, baseGy - 6);

    // Feet (Glossy metallic black/grey caps)
    _drawShadedFoot(canvas, leftLegEnd);
    _drawShadedFoot(canvas, rightLegEnd);

    // Cylindrical 3D Shaded Legs
    _drawShadedCapsule(canvas, leftLegStart, leftLegEnd, 8.5);
    _drawShadedCapsule(canvas, rightLegStart, rightLegEnd, 8.5);

    // Leg Attachment Joints
    _drawJointSphere(canvas, leftLegStart, 4.8);
    _drawJointSphere(canvas, rightLegStart, 4.8);

    // 3. Draw Torso (Body) with Radial 3D Shading
    canvas.save();
    // Tilt body slightly if dancing
    canvas.translate(bodyCenter.dx, bodyCenter.dy);
    canvas.rotate(bodyTilt);
    canvas.translate(-bodyCenter.dx, -bodyCenter.dy);

    final torsoRect = Rect.fromCenter(center: bodyCenter, width: 36, height: 34);
    _drawShadedTorso(canvas, torsoRect);

    // Red Cross Chest Badge (Matching the new uploaded medical robot)
    final badgeCenter = bodyCenter + const Offset(0, 2);
    
    // Glowing red aura behind cross
    final crossGlow = Paint()
      ..color = const Color(0xFFD50000).withValues(alpha: 0.15 * pulseValue + 0.1)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);
    canvas.drawCircle(badgeCenter, 11, crossGlow);

    final badgePaint = Paint()..color = const Color(0xFFD50000); // Red Cross Red
    canvas.drawCircle(badgeCenter, 8.0, badgePaint);

    final crossPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.square;
    // Horizontal bar
    canvas.drawLine(badgeCenter - const Offset(4.5, 0), badgeCenter + const Offset(4.5, 0), crossPaint);
    // Vertical bar
    canvas.drawLine(badgeCenter - const Offset(0, 4.5), badgeCenter + const Offset(0, 4.5), crossPaint);
    canvas.restore();

    // 4. Draw Neck Link (Metallic Chrome rod)
    final neckStart = Offset(cx, bodyCenter.dy - 16);
    final neckEnd = Offset(cx, headCenter.dy + 14);
    _drawShadedCapsule(canvas, neckStart, neckEnd, 5.0, isMetallic: true);

    // 5. Draw Head Stack (tilting dynamically relative to neck)
    canvas.save();
    canvas.translate(headCenter.dx, headCenter.dy);
    canvas.rotate(headTilt);
    canvas.translate(-headCenter.dx, -headCenter.dy);

    // Red Pin Ear indicators (stick + red sphere) - Matching new uploaded medical robot
    final leftEarStickStart = headCenter - const Offset(21, 0);
    final leftEarStickEnd = headCenter - const Offset(24, 9);
    final rightEarStickStart = headCenter + const Offset(21, 0);
    final rightEarStickEnd = headCenter + const Offset(24, 9);

    final stickPaint = Paint()
      ..color = const Color(0xFF546E7A)
      ..strokeWidth = 2.0;
    canvas.drawLine(leftEarStickStart, leftEarStickEnd, stickPaint);
    canvas.drawLine(rightEarStickStart, rightEarStickEnd, stickPaint);

    final ballPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.white,
          Colors.redAccent,
          const Color(0xFFD50000),
        ],
        center: const Alignment(-0.25, -0.25),
      ).createShader(Rect.fromCircle(center: leftEarStickEnd, radius: 4));

    canvas.drawCircle(leftEarStickEnd, 4, ballPaint);
    canvas.drawCircle(rightEarStickEnd, 4, ballPaint);

    // Glossy White rounded Head shell
    final headRect = Rect.fromCenter(center: headCenter, width: 44, height: 36);
    _drawShadedHead(canvas, headRect);

    // Red Emergency Siren on top of Head shell (Matching the new uploaded medical robot)
    final sirenRect = Rect.fromCenter(center: headCenter - const Offset(0, 19), width: 12, height: 9);
    final sirenRRect = RRect.fromRectAndRadius(sirenRect, const Radius.circular(3));
    final sirenPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.white,
          Colors.redAccent,
          const Color(0xFFD50000), // Crimson red
        ],
        center: const Alignment(-0.2, -0.2),
      ).createShader(sirenRect);
    canvas.drawRRect(sirenRRect, sirenPaint);

    // Draw siren metallic base connection
    final sirenBase = Paint()
      ..color = const Color(0xFF546E7A)
      ..style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromCenter(center: headCenter - const Offset(0, 15), width: 14, height: 2), sirenBase);

    // Flashing siren beam glow
    final sirenGlow = Paint()
      ..color = Colors.redAccent.withValues(alpha: 0.35 * pulseValue)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    canvas.drawCircle(headCenter - const Offset(0, 19), 10, sirenGlow);

    // Dark black Glass plate display screen
    final faceRect = Rect.fromCenter(center: headCenter - const Offset(0, 1), width: 34, height: 25);
    _drawGlassFaceplate(canvas, faceRect);

    // Draw glowing cyan cybernetic eyes
    _drawGlowingEyes(canvas, headCenter - const Offset(0, 1));

    canvas.restore();

    // 6. Draw Left Arm (waves, folds, or rests)
    final leftShoulder = Offset(bodyCenter.dx - 18, bodyCenter.dy - 10);
    _drawJointSphere(canvas, leftShoulder, 5.2);

    canvas.save();
    canvas.translate(leftShoulder.dx, leftShoulder.dy);
    canvas.rotate(leftArmAngle);
    canvas.translate(-leftShoulder.dx, -leftShoulder.dy);

    final leftArmEnd = leftShoulder + const Offset(-15, 10);
    _drawShadedCapsule(canvas, leftShoulder, leftArmEnd, 7.5);
    _drawShadedHand(canvas, leftArmEnd);

    // Red First Aid Medical Case hanging from Left Hand (Matching new uploaded medical robot)
    final boxCenter = leftArmEnd + const Offset(-4, 12);
    final boxRect = Rect.fromCenter(center: boxCenter, width: 22, height: 16);
    final boxRRect = RRect.fromRectAndRadius(boxRect, const Radius.circular(4));
    final boxPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.redAccent,
          const Color(0xFFD50000),
        ],
        center: const Alignment(-0.2, -0.2),
      ).createShader(boxRect);
    canvas.drawRRect(boxRRect, boxPaint);

    // Draw handle on top of case
    final handlePaint = Paint()
      ..color = const Color(0xFF37474F)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    final handlePath = Path()
      ..moveTo(boxCenter.dx - 5, boxCenter.dy - 8)
      ..quadraticBezierTo(boxCenter.dx, boxCenter.dy - 12, boxCenter.dx + 5, boxCenter.dy - 8);
    canvas.drawPath(handlePath, handlePaint);

    // Draw white cross on the case
    final boxCrossPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.0;
    // Horizontal bar
    canvas.drawLine(boxCenter - const Offset(4, 0), boxCenter + const Offset(4, 0), boxCrossPaint);
    // Vertical bar
    canvas.drawLine(boxCenter - const Offset(0, 4), boxCenter + const Offset(0, 4), boxCrossPaint);
    canvas.restore();

    // 7. Draw Right Arm (points, waves, folds, or rests)
    final rightShoulder = Offset(bodyCenter.dx + 18, bodyCenter.dy - 10);
    _drawJointSphere(canvas, rightShoulder, 5.2);

    canvas.save();
    canvas.translate(rightShoulder.dx, rightShoulder.dy);
    canvas.rotate(rightArmAngle);
    canvas.translate(-rightShoulder.dx, -rightShoulder.dy);

    final rightArmEnd = rightShoulder + const Offset(15, 10);
    _drawShadedCapsule(canvas, rightShoulder, rightArmEnd, 7.5);
    _drawShadedHand(canvas, rightArmEnd);
    canvas.restore();

    canvas.restore(); // end hover
  }

  // ------------------------------------------------------------
  // SHADING & LAYER DRAWING HELPERS
  // ------------------------------------------------------------
  void _drawShadedFoot(Canvas canvas, Offset pos) {
    final rect = Rect.fromCenter(center: pos + const Offset(0, 3), width: 13, height: 5);
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(2.5));
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.white,
          const Color(0xFFB0BEC5),
          const Color(0xFF546E7A),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(rect);
    canvas.drawRRect(rrect, paint);
  }

  void _drawShadedHand(Canvas canvas, Offset pos) {
    final rect = Rect.fromCircle(center: pos, radius: 4.2);
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.white,
          const Color(0xFFCFD8DC),
          const Color(0xFF78909C),
        ],
        center: const Alignment(-0.35, -0.35),
      ).createShader(rect);
    canvas.drawOval(rect, paint);
  }

  void _drawJointSphere(Canvas canvas, Offset pos, double radius) {
    final rect = Rect.fromCircle(center: pos, radius: radius);
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFECEFF1),
          const Color(0xFF455A64),
        ],
        center: const Alignment(-0.3, -0.3),
      ).createShader(rect);
    canvas.drawCircle(pos, radius, paint);
  }

  void _drawShadedCapsule(Canvas canvas, Offset start, Offset end, double width, {bool isMetallic = false}) {
    final paint = Paint()
      ..strokeWidth = width
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final double dx = end.dx - start.dx;
    final double dy = end.dy - start.dy;
    final double len = math.sqrt(dx * dx + dy * dy);
    if (len == 0) return;
    
    // Perpendicular vector for gradient orientation
    final double px = -dy / len;
    final double py = dx / len;

    final gradStart = Offset(start.dx - px * width / 2, start.dy - py * width / 2);
    final gradEnd = Offset(start.dx + px * width / 2, start.dy + py * width / 2);

    final colors = isMetallic
        ? [const Color(0xFFECEFF1), const Color(0xFF78909C), const Color(0xFF37474F)]
        : [Colors.white, const Color(0xFFECEFF1), const Color(0xFFB0BEC5)];

    paint.shader = LinearGradient(
      colors: colors,
      stops: const [0.0, 0.45, 1.0],
    ).createShader(Rect.fromPoints(gradStart, gradEnd));

    canvas.drawLine(start, end, paint);
  }

  void _drawShadedTorso(Canvas canvas, Rect rect) {
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(rect.width * 0.3));
    
    // 3D Spherical/Radial Shading
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.white,
          const Color(0xFFF4F6F7),
          const Color(0xFFB0BEC5),
        ],
        stops: const [0.0, 0.55, 1.0],
        center: const Alignment(-0.3, -0.35),
        radius: 0.85,
      ).createShader(rect);
    canvas.drawRRect(rrect, paint);
  }

  void _drawShadedHead(Canvas canvas, Rect rect) {
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(rect.height * 0.45));
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.white,
          const Color(0xFFF2F4F5),
          const Color(0xFFB0BEC5),
        ],
        stops: const [0.0, 0.6, 1.0],
        center: const Alignment(-0.25, -0.3),
        radius: 0.9,
      ).createShader(rect);
    canvas.drawRRect(rrect, paint);
  }



  void _drawGlassFaceplate(Canvas canvas, Rect rect) {
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(rect.height * 0.35));
    
    // Deep black reflective glass base
    final bgPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          const Color(0xFF0C0C12),
          const Color(0xFF161622),
          const Color(0xFF202030),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(rect);
    canvas.drawRRect(rrect, bgPaint);

    // Cyan glowing rim light path
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..shader = LinearGradient(
        colors: [
          const Color(0xFF00E5FF).withValues(alpha: 0.6),
          const Color(0xFF00E5FF).withValues(alpha: 0.05),
          const Color(0xFF00E5FF).withValues(alpha: 0.5),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(rect);
    canvas.drawRRect(rrect, borderPaint);

    // Diagonal glass highlight / reflection overlay
    final highlightPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.white.withValues(alpha: 0.12),
          Colors.white.withValues(alpha: 0.0),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: const [0.1, 0.4],
      ).createShader(rect);
    canvas.drawRRect(rrect, highlightPaint);
  }



  void _drawGlowingEyes(Canvas canvas, Offset headCenter) {
    final eyePaint = Paint()
      ..color = const Color(0xFF00E5FF)
      ..style = PaintingStyle.fill;

    // Glowing blur pass
    final glowPaint = Paint()
      ..color = const Color(0xFF00E5FF).withValues(alpha: 0.65)
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.0);

    // Offset pupil center points
    final leftEyeCenter = headCenter - const Offset(8, 0) + Offset(eyeOffsetX, eyeOffsetY);
    final rightEyeCenter = headCenter + const Offset(8, 0) + Offset(eyeOffsetX, eyeOffsetY);

    // Apply eye blinking scale
    canvas.save();
    canvas.translate(headCenter.dx, headCenter.dy);
    canvas.scale(1.0, blinkValue);
    canvas.translate(-headCenter.dx, -headCenter.dy);

    switch (eyeExpression) {
      case EyeExpression.smile:
        _drawSmilePath(canvas, leftEyeCenter, glowPaint, eyePaint);
        _drawSmilePath(canvas, rightEyeCenter, glowPaint, eyePaint);
        break;

      case EyeExpression.excited:
        final rSize = 3.8 * eyeScale;
        canvas.drawCircle(leftEyeCenter, rSize, glowPaint);
        canvas.drawCircle(leftEyeCenter, rSize, eyePaint);
        canvas.drawCircle(rightEyeCenter, rSize, glowPaint);
        canvas.drawCircle(rightEyeCenter, rSize, eyePaint);
        // Reflection highlights
        final refPaint = Paint()..color = Colors.white.withValues(alpha: 0.85);
        canvas.drawCircle(leftEyeCenter - const Offset(1.0, 1.0), 0.9 * eyeScale, refPaint);
        canvas.drawCircle(rightEyeCenter - const Offset(1.0, 1.0), 0.9 * eyeScale, refPaint);
        break;

      case EyeExpression.thinking:
        // Left eye normal, right eye offset/larger
        final lSize = 2.8 * eyeScale;
        final rSize = 3.4 * eyeScale;
        canvas.drawCircle(leftEyeCenter, lSize, glowPaint);
        canvas.drawCircle(leftEyeCenter, lSize, eyePaint);
        
        canvas.drawCircle(rightEyeCenter, rSize, glowPaint);
        canvas.drawCircle(rightEyeCenter, rSize, eyePaint);
        break;

      case EyeExpression.wink:
        // Left eye normal, right eye wink line
        final lSize = 3.0 * eyeScale;
        canvas.drawCircle(leftEyeCenter, lSize, glowPaint);
        canvas.drawCircle(leftEyeCenter, lSize, eyePaint);

        final winkRect = Rect.fromCenter(center: rightEyeCenter, width: 6.5 * eyeScale, height: 1.5 * eyeScale);
        final winkRRect = RRect.fromRectAndRadius(winkRect, const Radius.circular(0.8));
        canvas.drawRRect(winkRRect, glowPaint);
        canvas.drawRRect(winkRRect, eyePaint);
        break;

      case EyeExpression.normal:
        // Friendly ovals
        final leftRect = Rect.fromCenter(center: leftEyeCenter, width: 5.5 * eyeScale, height: 6.5 * eyeScale);
        final rightRect = Rect.fromCenter(center: rightEyeCenter, width: 5.5 * eyeScale, height: 6.5 * eyeScale);
        canvas.drawOval(leftRect, glowPaint);
        canvas.drawOval(leftRect, eyePaint);
        canvas.drawOval(rightRect, glowPaint);
        canvas.drawOval(rightRect, eyePaint);
        // Soft white reflect
        final refPaint = Paint()..color = Colors.white.withValues(alpha: 0.8);
        canvas.drawCircle(leftEyeCenter - const Offset(1.0, 1.0), 0.8 * eyeScale, refPaint);
        canvas.drawCircle(rightEyeCenter - const Offset(1.0, 1.0), 0.8 * eyeScale, refPaint);
        break;
    }

    canvas.restore();
  }

  void _drawSmilePath(Canvas canvas, Offset center, Paint glow, Paint solid) {
    final path = Path();
    final double w = 6.0 * eyeScale;
    final double h = 5.0 * eyeScale;
    path.moveTo(center.dx - w/2, center.dy + h/3);
    path.quadraticBezierTo(center.dx, center.dy - h*2/3, center.dx + w/2, center.dy + h/3);

    final strokePaint = Paint()
      ..color = solid.color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8 * eyeScale
      ..strokeCap = StrokeCap.round;

    final glowStrokePaint = Paint()
      ..color = glow.color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4 * eyeScale
      ..strokeCap = StrokeCap.round
      ..maskFilter = glow.maskFilter;

    canvas.drawPath(path, glowStrokePaint);
    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

