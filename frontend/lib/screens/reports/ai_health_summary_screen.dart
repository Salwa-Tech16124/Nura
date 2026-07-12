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
import '../../services/ai_service.dart';

class AIHealthSummaryScreen extends ConsumerStatefulWidget {
  const AIHealthSummaryScreen({super.key});

  @override
  ConsumerState<AIHealthSummaryScreen> createState() => _AIHealthSummaryScreenState();
}

class _AIHealthSummaryScreenState extends ConsumerState<AIHealthSummaryScreen> {
  String? _summary;
  List<String>? _risks;
  bool _isLoadingSummary = true;
  bool _isLoadingRisks = true;
  String? _summaryError;
  String? _risksError;

  @override
  void initState() {
    super.initState();
    _fetchSummary();
    _fetchRisks();
  }

  Future<void> _fetchSummary() async {
    try {
      final summary = await ref.read(aiServiceProvider).getSummary();
      if (mounted) {
        setState(() {
          _summary = summary;
          _isLoadingSummary = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _summaryError = 'Failed to load health summary.';
          _isLoadingSummary = false;
        });
      }
    }
  }

  Future<void> _fetchRisks() async {
    try {
      final risks = await ref.read(aiServiceProvider).getRiskAnalysis();
      if (mounted) {
        setState(() {
          _risks = risks;
          _isLoadingRisks = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _risksError = 'Failed to load risk analysis.';
          _isLoadingRisks = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
            if (_isLoadingSummary)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(AppSpacing.md),
                  child: CircularProgressIndicator(color: Colors.black),
                ),
              )
            else if (_summaryError != null)
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFCDD2),
                  border: Border.all(color: Colors.red, width: 1.8),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  _summaryError!,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ),
              )
            else
              InformationCard(
                title: 'Hello ${ref.watch(authStateProvider).user?.name.split(' ').first ?? 'John'},',
                description: _summary ?? 'No summary generated.',
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
            if (_isLoadingRisks)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(AppSpacing.md),
                  child: CircularProgressIndicator(color: Colors.black),
                ),
              )
            else if (_risksError != null)
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFCDD2),
                  border: Border.all(color: Colors.red, width: 1.8),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  _risksError!,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ),
              )
            else if (_risks == null || _risks!.isEmpty)
              const Padding(
                padding: EdgeInsets.all(AppSpacing.sm),
                child: Text(
                  'No significant risks detected.',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white70),
                ),
              )
            else
              ..._risks!.map((risk) => Column(
                    children: [
                      HealthRiskCard(title: risk),
                      const SizedBox(height: AppSpacing.sm),
                    ],
                  )),
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
