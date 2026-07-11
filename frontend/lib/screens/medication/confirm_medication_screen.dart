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

class ConfirmMedicationScreen extends StatelessWidget {
  const ConfirmMedicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: 'Confirm Medication'),
      body: PageContainer(
        child: ScrollablePageLayout(
          children: [
            // Medicine Card
            const SectionHeader(title: 'Medication Details'),
            MedicineCard(
              name: 'Lisinopril 10 mg',
              dosage: '1 Pill',
              time: '8:00 AM',
              isTaken: false,
              statusBadge: const PendingBadge(label: 'Pending'),
              onTap: () {},
            ),
            const SizedBox(height: AppSpacing.xxl),

            // Confirmation Area
            Center(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    decoration: BoxDecoration(
                      color: AppColors.successLight,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_circle_outline,
                      size: 64,
                      color: AppColors.success,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Have you taken this medication?',
                    style: AppTypography.h3,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),

            // Actions
            PrimaryButton(
              text: 'Confirm Taken',
              onPressed: () {
                context.go('/meds-history');
              },
            ),
            const SizedBox(height: AppSpacing.md),
            SecondaryButton(
              text: 'Cancel',
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go('/meds-notification');
                }
              },
            ),
            const SizedBox(height: AppSpacing.xl),

            // Success Information
            const InformationCard(
              title: 'Adherence Update',
              description: 'Your medication adherence has been updated.',
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}
