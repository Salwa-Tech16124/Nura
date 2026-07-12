import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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

void _showInfoDialog(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(),
          child: const Text('Close'),
        ),
      ],
    ),
  );
}

class AboutNuraScreen extends StatelessWidget {
  const AboutNuraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0A0C16) : AppColors.background,
      appBar: AppBar(
        title: Text('About NURA', style: AppTypography.h2.copyWith(color: isDark ? Colors.white : Colors.black)),
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
              'Your AI-powered healthcare companion.', 
              style: AppTypography.bodyLarge.copyWith(color: isDark ? Colors.white70 : AppColors.textSecondary),
            ),
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
            SupportOptionCard(
              title: 'Help Center',
              icon: Icons.help_center,
              onTap: () => _showInfoDialog(context, 'Help Center', 'Visit our Help Center at nura.health/help for guides and tutorials on using the NURA app.'),
            ),
            const SizedBox(height: AppSpacing.sm),
            SupportOptionCard(
              title: 'FAQs',
              icon: Icons.question_answer,
              onTap: () => _showInfoDialog(context, 'FAQs', 'Frequently Asked Questions:\n\n• How do I add a medication?\n• How do I invite a caregiver?\n• How do I use Voice AI?\n\nVisit nura.health/faq for full list.'),
            ),
            const SizedBox(height: AppSpacing.sm),
            SupportOptionCard(
              title: 'Contact Support',
              icon: Icons.support_agent,
              onTap: () => _showInfoDialog(context, 'Contact Support', 'Our support team is available 24/7.\n\nEmail: support@nura.health\nPhone: +1 800-NURA-CARE\nLive Chat: Available in the app.'),
            ),
            const SizedBox(height: AppSpacing.sm),
            SupportOptionCard(
              title: 'Email Support',
              icon: Icons.email,
              onTap: () => _showInfoDialog(context, 'Email Support', 'Send us an email at:\n\nsupport@nura.health\n\nWe respond within 24 hours on business days.'),
            ),
            const SizedBox(height: AppSpacing.sm),
            SupportOptionCard(
              title: 'Report a Problem',
              icon: Icons.report_problem,
              onTap: () => _showInfoDialog(context, 'Report a Problem', 'Encountered a bug or issue?\n\nPlease describe the problem and send it to:\nbugs@nura.health\n\nThank you for helping us improve NURA!'),
            ),
            const SizedBox(height: AppSpacing.sm),
            SupportOptionCard(
              title: 'Feedback',
              icon: Icons.feedback,
              onTap: () => _showInfoDialog(context, 'Feedback', 'We love hearing from you!\n\nShare your feedback at:\nfeedback@nura.health\n\nYour input helps us make NURA better for everyone.'),
            ),
            const SizedBox(height: AppSpacing.xl),

            // Section 4: Legal
            const SectionHeader(title: 'Legal'),
            SupportOptionCard(
              title: 'Privacy Policy',
              icon: Icons.privacy_tip,
              onTap: () => _showInfoDialog(context, 'Privacy Policy', 'NURA respects your privacy. We collect only the health data you provide and never sell your information to third parties.\n\nFull policy: nura.health/privacy'),
            ),
            const SizedBox(height: AppSpacing.sm),
            SupportOptionCard(
              title: 'Terms & Conditions',
              icon: Icons.gavel,
              onTap: () => _showInfoDialog(context, 'Terms & Conditions', 'By using NURA, you agree to our Terms of Service. NURA is a health companion app and does not replace professional medical advice.\n\nFull terms: nura.health/terms'),
            ),
            const SizedBox(height: AppSpacing.sm),
            SupportOptionCard(
              title: 'Open Source Licenses',
              icon: Icons.code,
              onTap: () => _showInfoDialog(context, 'Open Source Licenses', 'NURA is built using open source software including Flutter, Riverpod, and GoRouter.\n\nFor full license details visit: nura.health/licenses'),
            ),
            const SizedBox(height: AppSpacing.sm),
            SupportOptionCard(
              title: 'Data Usage Policy',
              icon: Icons.data_usage,
              onTap: () => _showInfoDialog(context, 'Data Usage Policy', 'Your health data is stored securely and used only to power NURA\'s AI features. You can delete your data at any time from Profile > Privacy & Security.\n\nFull policy: nura.health/data-usage'),
            ),
            const SizedBox(height: AppSpacing.xl),

            // Section 5: Our Mission
            const SectionHeader(title: 'Our Mission'),
            BaseCard(
              backgroundColor: isDark ? const Color(0xFF1D2235) : AppColors.primaryLight,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.track_changes, color: isDark ? Colors.white : AppColors.primary, size: 28),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      'Empower every elderly person to live independently with confidence using intelligent healthcare technology.',
                      style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.bold, color: isDark ? Colors.white : AppColors.primary),
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
            PrimaryButton(
              text: 'Contact Support',
              onPressed: () {
                _showInfoDialog(context, 'Contact Support', 'Email: support@nura.health\nPhone: +1 800-NURA-CARE\n\nSupport is available 24/7.');
              },
            ),
            const SizedBox(height: AppSpacing.md),
            SecondaryButton(
              text: 'Rate NURA',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Rate NURA'),
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) => const Icon(Icons.star, color: Colors.amber, size: 36)),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Thank you for rating NURA!')),
                          );
                        },
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: AppSpacing.md),
            OutlinedButtonWidget(
              text: 'Logout',
              onPressed: () {
                context.go('/login');
              },
            ),
            
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}
