import 'package:flutter/material.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../widgets/layout/page_container.dart';
import '../../widgets/buttons.dart';
import '../../widgets/misc.dart';
import '../../widgets/cards.dart';
import 'widgets/support_option_card.dart';
import 'widgets/roadmap_card.dart';
import '../../widgets/navigation.dart';

class AboutNuraScreen extends StatelessWidget {
  const AboutNuraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('About NURA', style: AppTypography.h2),
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: false,
      ),
      body: PageContainer(
        child: ScrollablePageLayout(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppSpacing.sm),
            Text('Your AI-powered healthcare companion.', style: AppTypography.bodyLarge.copyWith(color: AppColors.textSecondary)),
            const SizedBox(height: AppSpacing.xl),

            // Section 1: Application Branding
            Center(
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Icons.health_and_safety, color: AppColors.primary, size: 48),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text('NURA', style: AppTypography.h1.copyWith(color: AppColors.primary)),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'Intelligent Care.\nPersonalized for You.',
                    style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.bold, color: AppColors.textSecondary),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.xs),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                    ),
                    child: Text('Version 1.0.0 • Hackathon MVP', style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),

            // Section 2: About NURA
            const SectionHeader(title: 'About NURA'),
            const InformationCard(
              title: 'Our Purpose',
              description: 'NURA is an AI-powered healthcare companion designed to help elderly users manage medications, monitor health, communicate through voice, access emergency assistance, and generate AI-powered health reports.\n\nOur goal is to make healthcare simple, intelligent, and accessible.',
            ),
            const SizedBox(height: AppSpacing.xl),

            // Section 3: Help & Support
            const SectionHeader(title: 'Help & Support'),
            const SupportOptionCard(title: 'Help Center', icon: Icons.help_center),
            const SizedBox(height: AppSpacing.sm),
            const SupportOptionCard(title: 'FAQs', icon: Icons.question_answer),
            const SizedBox(height: AppSpacing.sm),
            const SupportOptionCard(title: 'Contact Support', icon: Icons.support_agent),
            const SizedBox(height: AppSpacing.sm),
            const SupportOptionCard(title: 'Email Support', icon: Icons.email),
            const SizedBox(height: AppSpacing.sm),
            const SupportOptionCard(title: 'Report a Problem', icon: Icons.report_problem),
            const SizedBox(height: AppSpacing.sm),
            const SupportOptionCard(title: 'Feedback', icon: Icons.feedback),
            const SizedBox(height: AppSpacing.xl),

            // Section 4: Legal
            const SectionHeader(title: 'Legal'),
            const SupportOptionCard(title: 'Privacy Policy', icon: Icons.privacy_tip),
            const SizedBox(height: AppSpacing.sm),
            const SupportOptionCard(title: 'Terms & Conditions', icon: Icons.gavel),
            const SizedBox(height: AppSpacing.sm),
            const SupportOptionCard(title: 'Open Source Licenses', icon: Icons.code),
            const SizedBox(height: AppSpacing.sm),
            const SupportOptionCard(title: 'Data Usage Policy', icon: Icons.data_usage),
            const SizedBox(height: AppSpacing.xl),

            // Section 5: Our Mission
            const SectionHeader(title: 'Our Mission'),
            BaseCard(
              backgroundColor: AppColors.primaryLight,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.track_changes, color: AppColors.primary, size: 28),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      'Empower every elderly person to live independently with confidence using intelligent healthcare technology.',
                      style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.bold, color: AppColors.primary),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            // Section 6: Future Roadmap
            const SectionHeader(title: 'Future Roadmap'),
            const RoadmapCard(featureName: 'Diet Planner & Calorie Counter', icon: Icons.restaurant),
            const SizedBox(height: AppSpacing.sm),
            const RoadmapCard(featureName: 'Hospital Integration', icon: Icons.local_hospital),
            const SizedBox(height: AppSpacing.sm),
            const RoadmapCard(featureName: 'Smart Watch Integration', icon: Icons.watch),
            const SizedBox(height: AppSpacing.sm),
            const RoadmapCard(featureName: 'Doctor Portal & Telemedicine', icon: Icons.medical_services),
            const SizedBox(height: AppSpacing.sm),
            const RoadmapCard(featureName: 'Family Dashboard & Caregivers', icon: Icons.family_restroom),
            const SizedBox(height: AppSpacing.sm),
            const RoadmapCard(featureName: 'Wearable Device Support', icon: Icons.devices_other),
            const SizedBox(height: AppSpacing.sm),
            const RoadmapCard(featureName: 'Offline Wellness Guide', icon: Icons.wifi_off),
            const SizedBox(height: AppSpacing.sm),
            const RoadmapCard(featureName: 'Medicine Delivery Integration & Pharmacy', icon: Icons.local_pharmacy),
            const SizedBox(height: AppSpacing.sm),
            const RoadmapCard(featureName: 'Insurance Portal & Claims', icon: Icons.health_and_safety),
            const SizedBox(height: AppSpacing.xl),

            // Section 7: Team
            Center(
              child: Column(
                children: [
                  Text('Designed & Developed by', style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary)),
                  const SizedBox(height: AppSpacing.xs),
                  Text('Team NURA', style: AppTypography.h2.copyWith(color: AppColors.primary)),
                  const SizedBox(height: AppSpacing.xs),
                  Text('Hackathon 2026', style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary)),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),

            // Bottom Actions
            PrimaryButton(text: 'Contact Support', onPressed: () {}),
            const SizedBox(height: AppSpacing.md),
            SecondaryButton(text: 'Rate NURA', onPressed: () {}),
            const SizedBox(height: AppSpacing.md),
            OutlinedButtonWidget(text: 'Logout', onPressed: () {}),
            
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}
