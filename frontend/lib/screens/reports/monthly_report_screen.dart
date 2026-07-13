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
import 'widgets/stat_card.dart';
import 'widgets/health_score_card.dart';
import 'widgets/achievement_card.dart';
import 'widgets/recommendation_card.dart';
import 'widgets/progress_comparison_card.dart';
import '../../widgets/navigation.dart';
import '../../providers/report_provider.dart';

class MonthlyReportScreen extends ConsumerWidget {
  const MonthlyReportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportAsync = ref.watch(monthlyReportProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Monthly Health Report', style: AppTypography.h2),
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: false,
      ),
      body: PageContainer(
        child: ScrollablePageLayout(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppSpacing.sm),
            Text('Your health performance over the last 30 days.',
                style: AppTypography.bodyLarge
                    .copyWith(color: AppColors.textSecondary)),
            const SizedBox(height: AppSpacing.lg),

            // Live stats from backend
            reportAsync.when(
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(AppSpacing.xl),
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (e, _) => Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange),
                ),
                child: Text(
                  'Could not load monthly report. Showing static preview.',
                  style: TextStyle(color: Colors.orange.shade800),
                ),
              ),
              data: (report) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(title: 'Monthly Statistics'),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: AppSpacing.md,
                    crossAxisSpacing: AppSpacing.md,
                    childAspectRatio: 1.5,
                    children: [
                      StatCard(
                          title: 'Active Medicines',
                          value: '${report.activeMedicines}',
                          icon: Icons.medication),
                      StatCard(
                          title: 'Health Logs',
                          value: '${report.healthLogsRecorded}',
                          icon: Icons.favorite),
                      StatCard(
                          title: 'Avg Blood Sugar',
                          value: report.sugarDisplay,
                          icon: Icons.water_drop),
                      StatCard(
                          title: 'Avg Weight',
                          value: report.weightDisplay,
                          icon: Icons.monitor_weight),
                      StatCard(
                          title: 'Avg Sleep',
                          value: report.sleepDisplay,
                          icon: Icons.bedtime),
                      StatCard(
                          title: 'Upcoming Appts',
                          value: '${report.upcomingAppointments}',
                          icon: Icons.calendar_today),
                      StatCard(
                          title: 'SOS Triggers',
                          value: '${report.sosTriggers}',
                          icon: Icons.sos),
                      StatCard(
                          title: 'Period',
                          value: '${report.periodDays} Days',
                          icon: Icons.date_range),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),
                ],
              ),
            ),

            // Section 1: Monthly Health Score
            const SectionHeader(title: 'Monthly Health Score'),
            const HealthScoreCard(
              score: '91 / 100',
              status: 'Excellent Progress',
              description:
                  '"Your health has consistently improved throughout this month."',
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
            const SizedBox(height: AppSpacing.xl),

            // Section 4: Monthly AI Summary
            const SectionHeader(title: 'Monthly AI Summary'),
            const InformationCard(
              title: 'AI Summary',
              description:
                  'This month you maintained excellent medication adherence, increased your daily activity, and showed stable blood pressure readings. Continue your current routine for even better long-term health.',
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
            const SizedBox(height: AppSpacing.xl),

            // Section 6: AI Recommendations
            const SectionHeader(title: 'AI Recommendations'),
            const RecommendationCard(text: 'Maintain your current routine.'),
            const SizedBox(height: AppSpacing.sm),
            const RecommendationCard(text: 'Increase daily stretching.'),
            const SizedBox(height: AppSpacing.sm),
            const RecommendationCard(text: 'Continue your walking habit.'),
            const SizedBox(height: AppSpacing.sm),
            const RecommendationCard(
                text: 'Schedule your monthly doctor check-up.'),
            const SizedBox(height: AppSpacing.xl),

            // Bottom Actions
            PrimaryButton(
                text: 'Generate Doctor Summary',
                onPressed: () => context.push('/doctor-summary')),
            const SizedBox(height: AppSpacing.md),
            SecondaryButton(
                text: 'Back to Weekly Report',
                onPressed: () => context.pop()),

            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}
