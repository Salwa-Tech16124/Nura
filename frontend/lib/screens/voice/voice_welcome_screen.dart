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
  // Animation controllers for premium 3D movement
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
  bool _glowExtra = false;
  int _messageIndex = 0;

  // Speech bubble variables
  String _bubbleText = "Namaste! 🙏";
  Timer? _activityTimer;
  Timer? _rotationTimer;

  // List of speech bubble messages to rotate
  final List<String> _idleMessages = [
    "Hello John 👋",
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
      duration: const Duration(milliseconds: 2400),
    );
    _hoverAnimation = Tween<double>(begin: 0.0, end: -7.0).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeInOut),
    );
    _hoverController.repeat(reverse: true);

    // 2. Arm Waving Animation
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    _waveAnimation = Tween<double>(begin: -0.2, end: 0.8).animate(
      CurvedAnimation(parent: _waveController, curve: Curves.easeInOut),
    );

    // 3. Torso Dancing Tilt Animation
    _danceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _danceAnimation = Tween<double>(begin: -0.12, end: 0.12).animate(
      CurvedAnimation(parent: _danceController, curve: Curves.easeInOut),
    );

    // 4. Eye Blink Controller
    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    // 5. Chest pulse glow animation
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _pulseAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _pulseController.repeat(reverse: true);

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
    _rotationTimer?.cancel();
    super.dispose();
  }

  // ------------------------------------------------------------
  // MICROINTERACTION TRIGGERS FROM PARENT
  // ------------------------------------------------------------
  void _handleTrigger() {
    final trigger = widget.triggerNotifier.value;
    if (trigger == null) return;

    _activityTimer?.cancel();
    _rotationTimer?.cancel();
    _waveController.stop();
    _danceController.stop();

    if (trigger == RobotTrigger.pointToSuggestions) {
      setState(() {
        _currentState = RobotState.pointing;
        _eyeExpression = EyeExpression.wink;
        _bubbleText = "You can ask me anything.";
      });
      // Lift arm to point at suggestion cards
      _waveController.animateTo(0.9, duration: const Duration(milliseconds: 300));
      
      _activityTimer = Timer(const Duration(milliseconds: 1600), _startIdleRotation);
    } 
    else if (trigger == RobotTrigger.startVoiceConversation) {
      setState(() {
        _currentState = RobotState.actionTransition;
        _eyeExpression = EyeExpression.excited;
        _bubbleText = "Let's talk 🎤";
        _glowExtra = true;
      });
      _waveController.repeat(reverse: true, period: const Duration(milliseconds: 250));
    }

    widget.triggerNotifier.value = null;
  }

  // ------------------------------------------------------------
  // GREETING SEQUENCE (On Load)
  // ------------------------------------------------------------
  Future<void> _runGreetingSequence() async {
    // 1. Waves and says Namaste!
    setState(() {
      _currentState = RobotState.greeting;
      _eyeExpression = EyeExpression.smile;
      _bubbleText = "Namaste 🙏";
    });
    _waveController.repeat(reverse: true);

    await Future.delayed(const Duration(milliseconds: 1600));
    if (!mounted || _currentState == RobotState.actionTransition) return;

    // 2. Looks at user and says Hello John 👋
    setState(() {
      _eyeExpression = EyeExpression.normal;
      _bubbleText = "Hello John 👋";
    });
    _waveController.animateTo(0.2, duration: const Duration(milliseconds: 300));

    await Future.delayed(const Duration(milliseconds: 1600));
    if (!mounted || _currentState == RobotState.actionTransition) return;

    // 3. I'm NURA AI Health Copilot
    setState(() {
      _eyeExpression = EyeExpression.smile;
      _bubbleText = "I'm NURA";
    });

    await Future.delayed(const Duration(milliseconds: 1800));
    _startIdleRotation();
  }

  // ------------------------------------------------------------
  // IDLE ROTATION MANAGEMENT
  // ------------------------------------------------------------
  void _startIdleRotation() {
    if (!mounted || _currentState == RobotState.actionTransition) return;

    _activityTimer?.cancel();
    _rotationTimer?.cancel();

    _enterIdleState();

    // Rotate bubble messages and animations every 4.5 seconds
    _rotationTimer = Timer.periodic(const Duration(milliseconds: 4500), (timer) {
      if (!mounted || _currentState == RobotState.actionTransition) {
        timer.cancel();
        return;
      }
      
      _messageIndex = (_messageIndex + 1) % _idleMessages.length;
      final nextMessage = _idleMessages[_messageIndex];

      setState(() {
        _bubbleText = nextMessage;
      });

      _triggerActivityForMessage(nextMessage);
    });
  }

  void _enterIdleState() {
    setState(() {
      _currentState = RobotState.idle;
      _eyeExpression = EyeExpression.normal;
      _glowExtra = false;
    });
    _waveController.stop();
    _danceController.stop();
  }

  void _triggerActivityForMessage(String message) {
    if (!mounted || _currentState == RobotState.actionTransition) return;

    _waveController.stop();
    _danceController.stop();

    if (message.contains("Namaste")) {
      setState(() {
        _currentState = RobotState.heart;
        _eyeExpression = EyeExpression.smile;
      });
      // Fold arms up
      _waveController.animateTo(0.7, duration: const Duration(milliseconds: 400));
      // Bounce jump
      _hoverController.duration = const Duration(milliseconds: 300);
      _hoverController.forward().then((_) => _hoverController.reverse().then((_) {
        _hoverController.duration = const Duration(milliseconds: 2400);
        _hoverController.repeat(reverse: true);
      }));
    } 
    else if (message.contains("talk") || message.contains("Copilot")) {
      setState(() {
        _currentState = RobotState.talking;
        _eyeExpression = EyeExpression.wink; // Listening wink
      });
      // Soft nod head by animating head tilt
      _hoverController.duration = const Duration(milliseconds: 1200);
    } 
    else if (message.contains("medicines") || message.contains("review")) {
      setState(() {
        _currentState = RobotState.thinking;
        _eyeExpression = EyeExpression.thinking;
      });
      // Hand on chin
      _waveController.animateTo(0.65, duration: const Duration(milliseconds: 400));
    } 
    else if (message.contains("feeling") || message.contains("health")) {
      setState(() {
        _currentState = RobotState.heart;
        _eyeExpression = EyeExpression.excited; // Heart/Caring expression
      });
      _waveController.animateTo(0.5, duration: const Duration(milliseconds: 300));
    } 
    else if (message.contains("Everything") || message.contains("Welcome")) {
      setState(() {
        _currentState = RobotState.dancing;
        _eyeExpression = EyeExpression.smile;
      });
      _danceController.repeat(reverse: true);
      _waveController.repeat(reverse: true, period: const Duration(milliseconds: 600));
    } 
    else {
      _enterIdleState();
    }
  }

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
        final double hoverVal = _hoverAnimation.value;
        double bodyTiltVal = 0.0;
        double headTiltVal = 0.0;
        double rightArmVal = 0.2;
        double leftArmVal = -0.2;

        // Map robot state animations to painter rotation parameters
        if (_currentState == RobotState.dancing) {
          bodyTiltVal = _danceAnimation.value;
          rightArmVal = 0.4 - (_danceAnimation.value * 2.0);
          leftArmVal = -0.4 + (_danceAnimation.value * 2.0);
        } 
        else if (_currentState == RobotState.greeting) {
          rightArmVal = _waveAnimation.value; // Waving hand
          leftArmVal = -0.25;
        } 
        else if (_currentState == RobotState.talking || _currentState == RobotState.actionTransition) {
          rightArmVal = _waveAnimation.value; // Talk hand movement
          headTiltVal = 0.05 * math.sin(_hoverController.value * math.pi * 2);
        } 
        else if (_currentState == RobotState.pointing) {
          rightArmVal = -1.25; // Pointing left towards suggestions
        } 
        else if (_currentState == RobotState.thinking) {
          rightArmVal = -0.85; // Touching chin
          headTiltVal = 0.12; // Tilt head
        } 
        else if (_currentState == RobotState.heart) {
          rightArmVal = -0.95; // Folds hands in Namaste
          leftArmVal = 0.95;
        }

        return Column(
          children: [
            // Premium Speech Bubble
            SizedBox(
              height: 58,
              width: 135,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
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
            const SizedBox(height: 4),

            // Premium Redesigned 3D-shaded Robot Canvas
            SizedBox(
              width: 140,
              height: 118,
              child: CustomPaint(
                painter: PremiumRobotPainter(
                  hoverOffset: hoverVal,
                  bodyTilt: bodyTiltVal,
                  headTilt: headTiltVal,
                  rightArmAngle: rightArmVal,
                  leftArmAngle: leftArmVal,
                  pulseValue: _pulseAnimation.value,
                  blinkValue: 1.0, // Blinks managed inside painter internally
                  eyeExpression: _eyeExpression,
                  glowExtra: _glowExtra,
                  danceStep: _currentState == RobotState.dancing ? _danceAnimation.value : 0.0,
                ),
              ),
            ),
          ],
        );
      },
    );
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
    final headCenter = Offset(cx, size.height - 84);

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

    // Cyber Heart Glowing Chest Logo
    _drawGlowingChestCore(canvas, bodyCenter - const Offset(0, 1), pulseValue);
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

    // Side Ambient Blue ear indicators
    final leftEarCenter = headCenter - const Offset(23, 0);
    final rightEarCenter = headCenter + const Offset(23, 0);
    _drawAmbientEarIndicator(canvas, leftEarCenter, left: true);
    _drawAmbientEarIndicator(canvas, rightEarCenter, left: false);

    // Glossy White rounded Head shell
    final headRect = Rect.fromCenter(center: headCenter, width: 44, height: 36);
    _drawShadedHead(canvas, headRect);

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

  void _drawAmbientEarIndicator(Canvas canvas, Offset center, {required bool left}) {
    final rect = Rect.fromCircle(center: center, radius: 4.5);
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF00E5FF),
          const Color(0xFF0288D1).withValues(alpha: 0.8),
          const Color(0xFF1E244A),
        ],
        stops: const [0.2, 0.7, 1.0],
      ).createShader(rect);
    canvas.drawCircle(center, 4.5, paint);
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

  void _drawGlowingChestCore(Canvas canvas, Offset center, double pulse) {
    final double radius = 6.0;
    final double outerGlow = radius + (pulse * 8.0);

    // Aura pulse glow
    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF00E5FF).withValues(alpha: 0.5 * (1.0 - pulse * 0.35)),
          const Color(0xFF00E5FF).withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: outerGlow));
    canvas.drawCircle(center, outerGlow, glowPaint);

    // Core Solid White-blue center
    final corePaint = Paint()
      ..color = const Color(0xFFE0F7FA)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, corePaint);

    // Small cyber heart logo inside core
    final path = Path();
    final d = 3.5;
    path.moveTo(center.dx, center.dy + d);
    path.cubicTo(center.dx - d, center.dy + d/2, center.dx - d, center.dy - d/2, center.dx, center.dy - d/2);
    path.cubicTo(center.dx + d, center.dy - d/2, center.dx + d, center.dy + d/2, center.dx, center.dy + d);
    path.close();

    final logoPaint = Paint()
      ..color = const Color(0xFF00E5FF)
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, logoPaint);
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

    final leftEyeCenter = headCenter - const Offset(8, 0);
    final rightEyeCenter = headCenter + const Offset(8, 0);

    switch (eyeExpression) {
      case EyeExpression.smile:
        _drawSmilePath(canvas, leftEyeCenter, glowPaint, eyePaint);
        _drawSmilePath(canvas, rightEyeCenter, glowPaint, eyePaint);
        break;

      case EyeExpression.excited:
        // Large round glowing circles
        canvas.drawCircle(leftEyeCenter, 3.8, glowPaint);
        canvas.drawCircle(leftEyeCenter, 3.8, eyePaint);
        canvas.drawCircle(rightEyeCenter, 3.8, glowPaint);
        canvas.drawCircle(rightEyeCenter, 3.8, eyePaint);
        // Reflection highlights
        final refPaint = Paint()..color = Colors.white.withValues(alpha: 0.85);
        canvas.drawCircle(leftEyeCenter - const Offset(1.0, 1.0), 0.9, refPaint);
        canvas.drawCircle(rightEyeCenter - const Offset(1.0, 1.0), 0.9, refPaint);
        break;

      case EyeExpression.thinking:
        // Left eye normal, right eye offset/larger
        canvas.drawCircle(leftEyeCenter, 2.8, glowPaint);
        canvas.drawCircle(leftEyeCenter, 2.8, eyePaint);
        
        canvas.drawCircle(rightEyeCenter, 3.4, glowPaint);
        canvas.drawCircle(rightEyeCenter, 3.4, eyePaint);
        break;

      case EyeExpression.wink:
        // Left eye normal, right eye wink line
        canvas.drawCircle(leftEyeCenter, 3.0, glowPaint);
        canvas.drawCircle(leftEyeCenter, 3.0, eyePaint);

        final winkRect = Rect.fromCenter(center: rightEyeCenter, width: 6.5, height: 1.5);
        final winkRRect = RRect.fromRectAndRadius(winkRect, const Radius.circular(0.8));
        canvas.drawRRect(winkRRect, glowPaint);
        canvas.drawRRect(winkRRect, eyePaint);
        break;

      case EyeExpression.normal:
        // Friendly ovals
        final leftRect = Rect.fromCenter(center: leftEyeCenter, width: 5.5, height: 6.5);
        final rightRect = Rect.fromCenter(center: rightEyeCenter, width: 5.5, height: 6.5);
        canvas.drawOval(leftRect, glowPaint);
        canvas.drawOval(leftRect, eyePaint);
        canvas.drawOval(rightRect, glowPaint);
        canvas.drawOval(rightRect, eyePaint);
        // Soft white reflect
        final refPaint = Paint()..color = Colors.white.withValues(alpha: 0.8);
        canvas.drawCircle(leftEyeCenter - const Offset(1.0, 1.0), 0.8, refPaint);
        canvas.drawCircle(rightEyeCenter - const Offset(1.0, 1.0), 0.8, refPaint);
        break;
    }
  }

  void _drawSmilePath(Canvas canvas, Offset center, Paint glow, Paint solid) {
    final path = Path();
    final double w = 6.0;
    final double h = 5.0;
    path.moveTo(center.dx - w/2, center.dy + h/3);
    path.quadraticBezierTo(center.dx, center.dy - h*2/3, center.dx + w/2, center.dy + h/3);

    final strokePaint = Paint()
      ..color = solid.color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round;

    final glowStrokePaint = Paint()
      ..color = glow.color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round
      ..maskFilter = glow.maskFilter;

    canvas.drawPath(path, glowStrokePaint);
    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
