import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../widgets/layout/page_container.dart';
import '../../widgets/buttons.dart';
import '../../widgets/misc.dart';
import '../../widgets/cards.dart';
import 'widgets/health_score_card.dart';
import 'widgets/recommendation_card.dart';
import 'widgets/observation_card.dart';
import 'widgets/health_risk_card.dart';
import 'widgets/goal_progress_card.dart';
import '../../widgets/navigation.dart';
import '../../features/auth/providers/auth_state_provider.dart';

class AIHealthSummaryScreen extends ConsumerWidget {
  const AIHealthSummaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0A0C16) : AppColors.background,
      appBar: AppBar(
        title: Text('AI Health Summary', style: AppTypography.h2.copyWith(color: isDark ? Colors.white : Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: isDark ? Colors.white : Colors.black, size: 20),
          onPressed: () => context.pop(),
        ),
      ),
      body: PageContainer(
        child: ScrollablePageLayout(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Personalized insights generated from your health records.', 
              style: AppTypography.bodyLarge.copyWith(
                color: isDark ? Colors.white70 : AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Section 1: Overall AI Health Score
            const SectionHeader(title: 'Overall AI Health Score'),
            const HealthScoreCard(
              score: '90 / 100',
              status: 'Healthy Progress',
              description: '"Your health has remained stable over the last month."',
            ),
            const SizedBox(height: AppSpacing.xl),

            // Section 2: AI Summary Card
            const SectionHeader(title: 'AI Summary Card'),
            InformationCard(
              title: 'Hello ${ref.watch(authStateProvider).user?.name.split(' ').first ?? 'John'},',
              description: 'Based on your recent health records, your overall health is improving.\n\nYour medicine adherence has remained excellent.\n\nYour blood pressure and blood sugar levels have stayed within a healthy range.\n\nYour daily walking activity has increased compared to last month.\n\nKeep following your current routine.',
            ),
            const SizedBox(height: AppSpacing.xl),

            // Section 3: AI Observations
            const SectionHeader(title: 'AI Observations'),
            const ObservationCard(text: 'Medicine adherence improved.'),
            const SizedBox(height: AppSpacing.sm),
            const ObservationCard(text: 'Blood pressure remained stable.'),
            const SizedBox(height: AppSpacing.sm),
            const ObservationCard(text: 'Walking activity increased.'),
            const SizedBox(height: AppSpacing.sm),
            const ObservationCard(text: 'Hydration improved.'),
            const SizedBox(height: AppSpacing.sm),
            const ObservationCard(text: 'Heart rate remained normal.'),
            const SizedBox(height: AppSpacing.xl),

            // Section 4: Health Risks
            const SectionHeader(title: 'Health Risks'),
            const HealthRiskCard(title: 'Low Water Intake'),
            const SizedBox(height: AppSpacing.sm),
            const HealthRiskCard(title: 'Moderate Sleep Quality'),
            const SizedBox(height: AppSpacing.sm),
            const HealthRiskCard(title: 'Occasional Missed Medicines'),
            const SizedBox(height: AppSpacing.xl),

            // Section 5: Personalized Recommendations
            const SectionHeader(title: 'Personalized Recommendations'),
            const RecommendationCard(text: 'Walk 20 more minutes every day.'),
            const SizedBox(height: AppSpacing.sm),
            const RecommendationCard(text: 'Drink at least 2 litres of water.'),
            const SizedBox(height: AppSpacing.sm),
            const RecommendationCard(text: 'Maintain your medicine schedule.'),
            const SizedBox(height: AppSpacing.sm),
            const RecommendationCard(text: 'Reduce sugary foods.'),
            const SizedBox(height: AppSpacing.sm),
            const RecommendationCard(text: 'Sleep for 7–8 hours daily.'),
            const SizedBox(height: AppSpacing.xl),

            // Section 6: Weekly Goals
            const SectionHeader(title: 'Weekly Goals'),
            const GoalProgressCard(title: 'Medicine Goal', percentage: 1.0, displayValue: '100%'),
            const SizedBox(height: AppSpacing.sm),
            const GoalProgressCard(title: 'Walking Goal', percentage: 0.92, displayValue: '92%'),
            const SizedBox(height: AppSpacing.sm),
            const GoalProgressCard(title: 'Water Intake', percentage: 0.85, displayValue: '85%'),
            const SizedBox(height: AppSpacing.sm),
            const GoalProgressCard(title: 'Healthy Meals', percentage: 0.90, displayValue: '90%'),
            const SizedBox(height: AppSpacing.xl),

            // Bottom Actions
            PrimaryButton(text: 'Generate Doctor Summary', onPressed: () => context.push('/doctor-summary')),
            const SizedBox(height: AppSpacing.md),
            SecondaryButton(text: 'Back to Monthly Report', onPressed: () => context.pop()),
            
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}
