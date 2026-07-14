import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../widgets/layout/page_container.dart';
import '../../widgets/buttons.dart';
import '../../widgets/misc.dart';
import '../../widgets/cards.dart';
import 'widgets/report_preview_card.dart';
import 'widgets/share_option_card.dart';
import 'widgets/export_option_card.dart';
import 'widgets/success_status_card.dart';
import '../../widgets/navigation.dart';

class ShareReportScreen extends StatelessWidget {
  const ShareReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0A0C16) : AppColors.background,
      appBar: AppBar(
        title: Text('Share Report', style: AppTypography.h2.copyWith(color: isDark ? Colors.white : Colors.black)),
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
              'Share or export your health summary securely.', 
              style: AppTypography.bodyLarge.copyWith(
                color: isDark ? Colors.white70 : AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Section 1: Report Preview
            const SectionHeader(title: 'Report Preview'),
            const ReportPreviewCard(
              title: 'AI Health Report',
              date: 'Oct 12, 2026',
              pages: '5 Pages',
              format: 'PDF',
            ),
            const SizedBox(height: AppSpacing.xl),

            // Section 2: Share Options
            const SectionHeader(title: 'Share Options'),
            const ShareOptionCard(title: 'WhatsApp', description: 'Send via WhatsApp message', icon: Icons.chat),
            const SizedBox(height: AppSpacing.sm),
            const ShareOptionCard(title: 'Email', description: 'Send as email attachment', icon: Icons.email),
            const SizedBox(height: AppSpacing.sm),
            const ShareOptionCard(title: 'Family Members', description: 'Share with linked family accounts', icon: Icons.group),
            const SizedBox(height: AppSpacing.sm),
            const ShareOptionCard(title: 'Nearby Doctor', description: 'Secure transfer to a nearby clinic', icon: Icons.local_hospital),
            const SizedBox(height: AppSpacing.sm),
            const ShareOptionCard(title: 'Copy Share Link', description: 'Copy a secure 24-hour link', icon: Icons.link),
            const SizedBox(height: AppSpacing.sm),
            const ShareOptionCard(title: 'Save to Device', description: 'Save file directly to your phone', icon: Icons.save_alt),
            const SizedBox(height: AppSpacing.xl),

            // Section 3: Privacy Notice
            const SectionHeader(title: 'Privacy Notice'),
            const InformationCard(
              title: 'Data Protection',
              description: 'Your report will only be shared after your confirmation.\n\nNURA values your privacy and your health data remains protected.',
            ),
            const SizedBox(height: AppSpacing.xl),

            // Section 4: Export Options
            const SectionHeader(title: 'Export Options'),
            const ExportOptionCard(title: 'Download PDF', icon: Icons.picture_as_pdf),
            const SizedBox(height: AppSpacing.sm),
            const ExportOptionCard(title: 'Print Report', icon: Icons.print),
            const SizedBox(height: AppSpacing.sm),
            const ExportOptionCard(title: 'Save Offline', icon: Icons.cloud_download),
            const SizedBox(height: AppSpacing.sm),
            const ExportOptionCard(title: 'Generate QR Code (Future)', icon: Icons.qr_code),
            const SizedBox(height: AppSpacing.xl),

            // Section 5: Share Success Preview
            const SectionHeader(title: 'Status'),
            const SuccessStatusCard(
              title: 'Report Ready',
              message: 'Your AI Health Report is ready to be shared.',
            ),
            const SizedBox(height: AppSpacing.xl),

            // Bottom Actions
            PrimaryButton(text: 'Share Now', onPressed: () {}),
            const SizedBox(height: AppSpacing.md),
            SecondaryButton(text: 'Download PDF', onPressed: () {}),
            const SizedBox(height: AppSpacing.md),
            OutlinedButtonWidget(text: 'Back to Doctor Summary', onPressed: () => context.pop()),
            
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}
