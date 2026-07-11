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
              Color(0xFF0F0B09), // Warm dark charcoal/brown
              Color(0xFF070404), // Warm solid black
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppSpacing.lg),
                
                // Greeting and NURA Title
                Row(
                  children: [
                    Text(
                      'Hello John 👋',
                      style: AppTypography.bodyLarge.copyWith(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                const Text(
                  "I'm NURA",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 32,
                    letterSpacing: 0.5,
                  ),
                ),
                const Text(
                  "Your AI Health Copilot",
                  style: TextStyle(
                    color: Color(0xFF81C784), // Warm green matching theme
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                const Text(
                  "I understand your medicines, reports, symptoms and health history.\nHow can I help you today?",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),
                
                const SizedBox(height: AppSpacing.xl),
                
                // Suggestions Section
                const Text(
                  'Quick Suggestions',
                  style: TextStyle(
                    color: Colors.white60,
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
                        color: const Color(0xFF98BEF8),
                        title: 'Explain my medicines',
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      _buildSuggestionCard(
                        icon: Icons.description_outlined,
                        color: const Color(0xFFF7EC9F),
                        title: 'Summarize my latest report',
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      _buildSuggestionCard(
                        icon: Icons.trending_up_outlined,
                        color: const Color(0xFFA5E6BD),
                        title: 'Show my health timeline',
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      _buildSuggestionCard(
                        icon: Icons.science_outlined,
                        color: const Color(0xFFD3B6FC),
                        title: 'Explain my latest prescription',
                      ),
                    ],
                  ),
                ),
                
                // Bottom Buttons
                Column(
                  children: [
                    const SizedBox(height: AppSpacing.md),
                    PrimaryButton(
                      text: '🎤 Start Voice Conversation',
                      onPressed: () => context.push('/voice-standby'),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    OutlinedButtonWidget(
                      text: 'Skip',
                      color: Colors.white70,
                      onPressed: () => context.pop(),
                    ),
                    const SizedBox(height: AppSpacing.lg),
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
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withAlpha(12)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withAlpha(40),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          const Icon(Icons.arrow_forward_ios, color: Colors.white30, size: 16),
        ],
      ),
    );
  }
}
