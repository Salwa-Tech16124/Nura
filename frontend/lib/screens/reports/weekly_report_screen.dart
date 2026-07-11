import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../widgets/layout/page_container.dart';
import '../../widgets/buttons.dart';
import '../../widgets/misc.dart';
import '../../widgets/cards.dart';
import 'widgets/stat_card.dart';
import 'widgets/health_score_card.dart';
import 'widgets/achievement_card.dart';
import 'widgets/recommendation_card.dart';
import '../../widgets/navigation.dart';

class WeeklyReportScreen extends StatelessWidget {
  const WeeklyReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Weekly Health Report', style: AppTypography.h2),
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: false,
      ),
      body: PageContainer(
        child: ScrollablePageLayout(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppSpacing.sm),
            Text('Health summary for the last 7 days.', style: AppTypography.bodyLarge.copyWith(color: AppColors.textSecondary)),
            const SizedBox(height: AppSpacing.lg),

            // Section 1: Overall Health Score
            const SectionHeader(title: 'Overall Health Score'),
            const HealthScoreCard(
              score: '87 / 100',
              status: 'Good Progress',
              description: '"Your overall health has improved this week."',
            ),
            const SizedBox(height: AppSpacing.xl),

            // Section 2: Weekly Statistics
            const SectionHeader(title: 'Weekly Statistics'),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: AppSpacing.md,
              crossAxisSpacing: AppSpacing.md,
              childAspectRatio: 1.5,
              children: const [
                StatCard(title: 'Average Heart Rate', value: '76 BPM', icon: Icons.favorite),
                StatCard(title: 'Avg Blood Pressure', value: '122 / 80', icon: Icons.monitor_heart),
                StatCard(title: 'Avg Blood Sugar', value: '108 mg/dL', icon: Icons.water_drop),
                StatCard(title: 'Avg Daily Steps', value: '7,850', icon: Icons.directions_walk),
                StatCard(title: 'Medicine Adherence', value: '94%', icon: Icons.medication),
                StatCard(title: 'Calories Burned', value: '1,980 kcal', icon: Icons.local_fire_department),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),

            // Section 3: Weekly Health Summary
            const SectionHeader(title: 'Weekly Health Summary'),
            const InformationCard(
              title: 'AI Summary',
              description: 'This week you maintained good medication adherence and consistent daily activity. Your blood pressure remained stable throughout the week. Continue following your current routine.',
            ),
            const SizedBox(height: AppSpacing.xl),

            // Section 4: Achievements
            const SectionHeader(title: 'Achievements'),
            const AchievementCard(title: 'Medicines Taken Regularly'),
            const SizedBox(height: AppSpacing.sm),
            const AchievementCard(title: 'Walking Goal Achieved'),
            const SizedBox(height: AppSpacing.sm),
            const AchievementCard(title: 'Blood Pressure Stable'),
            const SizedBox(height: AppSpacing.sm),
            const AchievementCard(title: 'Hydration Goal Completed'),
            const SizedBox(height: AppSpacing.xl),

            // Section 5: Recommendations
            const SectionHeader(title: 'Recommendations'),
            const RecommendationCard(text: 'Walk 20 more minutes daily.'),
            const SizedBox(height: AppSpacing.sm),
            const RecommendationCard(text: 'Drink more water.'),
            const SizedBox(height: AppSpacing.sm),
            const RecommendationCard(text: 'Reduce salt intake.'),
            const SizedBox(height: AppSpacing.sm),
            const RecommendationCard(text: 'Maintain your sleep schedule.'),
            const SizedBox(height: AppSpacing.xl),

            // Bottom Actions
            PrimaryButton(text: 'View Monthly Report', onPressed: () => context.push('/monthly-report')),
            const SizedBox(height: AppSpacing.md),
            SecondaryButton(text: 'Back to Reports', onPressed: () => context.pop()),
            
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}
