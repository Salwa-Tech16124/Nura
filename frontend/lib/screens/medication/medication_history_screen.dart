import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/navigation.dart';
import '../../widgets/layout/page_container.dart';
import '../../widgets/cards.dart';
import '../../widgets/misc.dart';
import '../../widgets/buttons.dart';
import '../../widgets/badges.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/constants/app_spacing.dart';

class MedicationHistoryScreen extends StatelessWidget {
  const MedicationHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0A0C16) : AppColors.background,
      appBar: const CustomAppBar(title: 'Medication Adherence History'),
      body: PageContainer(
        child: ScrollablePageLayout(
          children: [
            // Summary Card
            BaseCard(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Today\'s Adherence', style: AppTypography.h3.copyWith(color: isDark ? Colors.white : null)),
                        const SizedBox(height: AppSpacing.sm),
                        Text('Taken: 4', style: AppTypography.bodyMedium.copyWith(color: isDark ? Colors.white70 : null)),
                        Text('Missed: 1', style: AppTypography.bodyMedium.copyWith(color: isDark ? Colors.white70 : null)),
                        const SizedBox(height: AppSpacing.sm),
                        Text('Success Rate: 80%', style: AppTypography.bodyLarge.copyWith(color: AppColors.success, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        const CircularProgressIndicator(
                          value: 0.8,
                          backgroundColor: AppColors.border,
                          color: AppColors.success,
                          strokeWidth: 8,
                        ),
                        Center(child: Text('80%', style: AppTypography.h3)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            // Filter Section
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ChoiceChip(
                    label: const Text('All'),
                    selected: true,
                    onSelected: (v) {},
                    selectedColor: AppColors.primaryLight,
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  ChoiceChip(
                    label: const Text('Taken'),
                    selected: false,
                    onSelected: (v) {},
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  ChoiceChip(
                    label: const Text('Missed'),
                    selected: false,
                    onSelected: (v) {},
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  ChoiceChip(
                    label: const Text('Pending'),
                    selected: false,
                    onSelected: (v) {},
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Timeline Section
            const SectionHeader(title: 'Timeline'),
            const SizedBox(height: AppSpacing.md),
            const TimelineItem(
              title: 'Lisinopril 10 mg',
              subtitle: '1 Pill • 8:00 AM',
              isSuccess: true,
              trailing: SuccessBadge(label: 'Taken'),
            ),
            const TimelineItem(
              title: 'Aspirin 81 mg',
              subtitle: '1 Pill • 9:00 AM',
              isSuccess: true,
              trailing: SuccessBadge(label: 'Taken'),
            ),
            const TimelineItem(
              title: 'Vitamin D3',
              subtitle: '1 Pill • 10:00 AM',
              isSuccess: false,
              trailing: ErrorBadge(label: 'Missed'),
            ),
            const TimelineItem(
              title: 'Metformin 500mg',
              subtitle: '1 Pill • 12:00 PM',
              isSuccess: true,
              trailing: SuccessBadge(label: 'Taken'),
            ),
            const TimelineItem(
              title: 'Amoxicillin',
              subtitle: '1 Pill • 4:00 PM',
              isSuccess: true,
              trailing: SuccessBadge(label: 'Taken'),
            ),
            const TimelineItem(
              title: 'Atorvastatin 20mg',
              subtitle: '1 Pill • 8:00 PM',
              isSuccess: null,
              isLast: true,
              trailing: PendingBadge(label: 'Pending'),
            ),
            const SizedBox(height: AppSpacing.xl),

            // Actions
            PrimaryButton(
              text: 'Back to Medication Dashboard',
              onPressed: () {
                context.go('/meds');
              },
            ),
            const SizedBox(height: AppSpacing.md),
            SecondaryButton(
              text: 'Export History',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Medication history exported to CSV successfully!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}
