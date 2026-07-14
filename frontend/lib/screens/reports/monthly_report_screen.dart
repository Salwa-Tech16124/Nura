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
import 'widgets/progress_comparison_card.dart';
import '../../widgets/navigation.dart';

class MonthlyReportScreen extends StatelessWidget {
  const MonthlyReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0A0C16) : AppColors.background,
      appBar: AppBar(
        title: Text('Monthly Health Report', style: AppTypography.h2.copyWith(color: isDark ? Colors.white : Colors.black)),
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
              'Your health performance over the last 30 days.', 
              style: AppTypography.bodyLarge.copyWith(
                color: isDark ? Colors.white70 : AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Section 1: Monthly Health Score
            const SectionHeader(title: 'Monthly Health Score'),
            const HealthScoreCard(
              score: '91 / 100',
              status: 'Excellent Progress',
              description: '"Your health has consistently improved throughout this month."',
            ),
            const SizedBox(height: AppSpacing.xl),

            // Section 2: Monthly Statistics
            const SectionHeader(title: 'Monthly Statistics'),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: AppSpacing.md,
              crossAxisSpacing: AppSpacing.md,
              childAspectRatio: 1.5,
              children: const [
                StatCard(title: 'Average Heart Rate', value: '74 BPM', icon: Icons.favorite),
                StatCard(title: 'Avg Blood Pressure', value: '120 / 78', icon: Icons.monitor_heart),
                StatCard(title: 'Avg Blood Sugar', value: '104 mg/dL', icon: Icons.water_drop),
                StatCard(title: 'Avg Daily Steps', value: '8,420', icon: Icons.directions_walk),
                StatCard(title: 'Medicine Adherence', value: '96%', icon: Icons.medication),
                StatCard(title: 'Calories Burned', value: '8,950 kcal', icon: Icons.local_fire_department),
                StatCard(title: 'Average Sleep', value: '7.5 Hours', icon: Icons.bedtime),
                StatCard(title: 'Water Intake', value: '2.3 Litres', icon: Icons.local_drink),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),

            // Section 3: Monthly Progress
            const SectionHeader(title: 'Monthly Progress'),
            const ProgressComparisonCard(
              title: 'Blood Pressure',
              status: 'Improved by 5%',
              icon: Icons.arrow_downward,
              statusColor: AppColors.success,
            ),
            const SizedBox(height: AppSpacing.sm),
            const ProgressComparisonCard(
              title: 'Steps',
              status: 'Increased by 18%',
              icon: Icons.arrow_upward,
              statusColor: AppColors.success,
            ),
            const SizedBox(height: AppSpacing.sm),
            const ProgressComparisonCard(
              title: 'Medicine Adherence',
              status: 'Improved by 8%',
              icon: Icons.arrow_upward,
              statusColor: AppColors.success,
            ),
            const SizedBox(height: AppSpacing.sm),
            const ProgressComparisonCard(
              title: 'Weight',
              status: 'Reduced by 1.4 kg',
              icon: Icons.arrow_downward,
              statusColor: AppColors.success,
            ),
            const SizedBox(height: AppSpacing.xl),

            // Section 4: Monthly AI Summary
            const SectionHeader(title: 'Monthly AI Summary'),
            const InformationCard(
              title: 'AI Summary',
              description: 'This month you maintained excellent medication adherence, increased your daily activity, and showed stable blood pressure readings. Continue your current routine for even better long-term health.',
            ),
            const SizedBox(height: AppSpacing.xl),

            // Section 5: Monthly Achievements
            const SectionHeader(title: 'Monthly Achievements'),
            const AchievementCard(title: '30 Day Medicine Streak'),
            const SizedBox(height: AppSpacing.sm),
            const AchievementCard(title: 'Walking Goal Achieved'),
            const SizedBox(height: AppSpacing.sm),
            const AchievementCard(title: 'Healthy Blood Pressure'),
            const SizedBox(height: AppSpacing.sm),
            const AchievementCard(title: 'Hydration Maintained'),
            const SizedBox(height: AppSpacing.sm),
            const AchievementCard(title: 'Active Lifestyle'),
            const SizedBox(height: AppSpacing.xl),

            // Section 6: AI Recommendations
            const SectionHeader(title: 'AI Recommendations'),
            const RecommendationCard(text: 'Maintain your current routine.'),
            const SizedBox(height: AppSpacing.sm),
            const RecommendationCard(text: 'Increase daily stretching.'),
            const SizedBox(height: AppSpacing.sm),
            const RecommendationCard(text: 'Continue your walking habit.'),
            const SizedBox(height: AppSpacing.sm),
            const RecommendationCard(text: 'Schedule your monthly doctor check-up.'),
            const SizedBox(height: AppSpacing.xl),

            // Bottom Actions
            PrimaryButton(text: 'Generate Doctor Summary', onPressed: () => context.push('/doctor-summary')),
            const SizedBox(height: AppSpacing.md),
            SecondaryButton(text: 'Back to Weekly Report', onPressed: () => context.pop()),
            
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}
