import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/navigation.dart';
import '../../widgets/layout/page_container.dart';
import '../../widgets/cards.dart';
import '../../widgets/buttons.dart';
import '../../widgets/badges.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/services/audio_service.dart';

class MedicationNotificationScreen extends StatefulWidget {
  const MedicationNotificationScreen({super.key});

  @override
  State<MedicationNotificationScreen> createState() => _MedicationNotificationScreenState();
}

class _MedicationNotificationScreenState extends State<MedicationNotificationScreen> {
  @override
  void initState() {
    super.initState();
    AudioService().playNotificationSound();
  }

  @override
  void dispose() {
    AudioService().stopNotificationSound();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0A0C16) : AppColors.background,
      appBar: const CustomAppBar(title: 'Medication Reminder'),
      body: PageContainer(
        child: ScrollablePageLayout(
          children: [
            // Top: Medication Reminder Notification Card
            const InformationCard(
              title: 'Medication Reminder',
              description: 'It\'s time to take your medication.',
            ),
            const SizedBox(height: AppSpacing.sm),
            MedicineCard(
              name: 'Lisinopril 10 mg',
              dosage: '1 Pill',
              time: '8:00 AM',
              isTaken: false,
              onTap: () {},
            ),
            const SizedBox(height: AppSpacing.lg),

            // Reminder Status
            const SectionHeader(title: 'Reminder Status'),
            BaseCard(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Status', style: AppTypography.bodyMedium.copyWith(color: isDark ? Colors.white70 : null)),
                      const PendingBadge(label: 'Pending'),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                    child: Divider(color: isDark ? Colors.white24 : AppColors.border),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Scheduled Time', style: AppTypography.bodyMedium.copyWith(color: isDark ? Colors.white70 : null)),
                      Text('8:00 AM', style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.bold, color: isDark ? Colors.white : null)),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Current Time', style: AppTypography.bodyMedium.copyWith(color: isDark ? Colors.white70 : null)),
                      Text('8:05 AM', style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.bold, color: isDark ? Colors.white : null)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            // Actions
            PrimaryButton(
              text: 'Mark as Taken',
              onPressed: () {
                context.go('/meds-confirm');
              },
            ),
            const SizedBox(height: AppSpacing.md),
            SecondaryButton(
              text: 'Remind Me Later',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Reminder snoozed for 15 minutes.'),
                    duration: Duration(seconds: 2),
                  ),
                );
                context.go('/meds');
              },
            ),
            const SizedBox(height: AppSpacing.md),
            Center(
              child: TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Medication reminder skipped.'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  context.go('/meds');
                },
                child: Text('Skip', style: AppTypography.button.copyWith(color: AppColors.textSecondary)),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            // Information Card
            const InformationCard(
              title: 'Family Alert System',
              description: 'If you miss multiple medications, your emergency contacts may be notified.',
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}
