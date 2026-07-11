import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/navigation.dart';
import '../../widgets/layout/page_container.dart';
import '../../widgets/cards.dart';
import '../../widgets/buttons.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/constants/app_spacing.dart';

class FamilyAlertScreen extends StatelessWidget {
  const FamilyAlertScreen({super.key});

  Widget _buildContactCard(String name, String relationship, String phone) {
    return BaseCard(
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.primaryLight,
            child: Text(name[0], style: AppTypography.h3.copyWith(color: AppColors.primary)),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
                Text(relationship, style: AppTypography.bodySmall),
                const SizedBox(height: 2),
                Text(phone, style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary)),
              ],
            ),
          ),
          // Green Status Indicator & Call Icon
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: AppColors.success,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              IconButton(
                icon: const Icon(Icons.phone, color: AppColors.error, size: 28),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: 'Critical Medication Alert'),
      body: PageContainer(
        child: ScrollablePageLayout(
          children: [
            // Critical Alert Banner matching the visual reference (Red box with warning icon)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32),
              decoration: BoxDecoration(
                color: AppColors.error,
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
              ),
              child: const Icon(Icons.warning_rounded, color: AppColors.textInverse, size: 64),
            ),
            const SizedBox(height: AppSpacing.lg),
            
            // Alert Headline matching image
            Text(
              'CRITICAL ALERT:\nMultiple Doses Missed by Eleanor.',
              style: AppTypography.h2.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),

            // Alert Details requested in prompt
            const SectionHeader(title: 'Alert Details'),
            BaseCard(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Patient Name', style: AppTypography.bodyMedium),
                      Text('Eleanor Rigby', style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: AppSpacing.xs), child: Divider(color: AppColors.border)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Medicine', style: AppTypography.bodyMedium),
                      Text('Lisinopril 10 mg', style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: AppSpacing.xs), child: Divider(color: AppColors.border)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Last Missed Time', style: AppTypography.bodyMedium),
                      Text('Today, 8:00 AM', style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: AppSpacing.xs), child: Divider(color: AppColors.border)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Missed Doses', style: AppTypography.bodyMedium),
                      Text('3 Consecutive', style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.bold, color: AppColors.error)),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: AppSpacing.xs), child: Divider(color: AppColors.border)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Risk Level', style: AppTypography.bodyMedium),
                      Text('High', style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.bold, color: AppColors.error)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            // Emergency Contacts
            const SectionHeader(title: 'Emergency Contacts'),
            _buildContactCard('Sarah', 'Daughter', '+1 555-0101'),
            const SizedBox(height: AppSpacing.sm),
            _buildContactCard('Mike', 'Son', '+1 555-0102'),
            const SizedBox(height: AppSpacing.sm),
            _buildContactCard('Dr. Anderson', 'Doctor', '+1 555-0103'),
            const SizedBox(height: AppSpacing.xl),

            // Emergency Status
            const InformationCard(
              title: 'Family Alert Status',
              description: 'Family members have been notified successfully. Emergency services will be contacted if medication continues to be missed.',
            ),
            const SizedBox(height: AppSpacing.xxl),

            // Bottom Actions
            PrimaryButton(
              text: 'Call Primary Contact',
              onPressed: () {},
            ),
            const SizedBox(height: AppSpacing.md),
            SecondaryButton(
              text: 'Back to Medication Dashboard',
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go('/meds');
                }
              },
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}
