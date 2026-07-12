import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../widgets/layout/page_container.dart';
import '../../widgets/buttons.dart';
import '../../widgets/misc.dart';
import '../../widgets/cards.dart';
import 'widgets/storage_summary_card.dart';
import 'widgets/medical_record_card.dart';
import 'widgets/category_card.dart';
import 'widgets/ocr_history_card.dart';
import '../../widgets/navigation.dart';

class MedicalRecordsScreen extends StatelessWidget {
  const MedicalRecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0A0C16) : AppColors.background,
      appBar: AppBar(
        title: Text('Medical Records', style: AppTypography.h2.copyWith(color: isDark ? Colors.white : Colors.black)),
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
              'Access all your health documents in one secure place.', 
              style: AppTypography.bodyLarge.copyWith(color: isDark ? Colors.white70 : AppColors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Section 1: Storage Summary
            const SectionHeader(title: 'Storage Summary'),
            const StorageSummaryCard(),
            const SizedBox(height: AppSpacing.xl),

            // Section 2: Recent Documents
            const SectionHeader(title: 'Recent Documents'),
            const MedicalRecordCard(title: 'Blood Test Report', category: 'Lab Reports', date: '12 June 2026'),
            const SizedBox(height: AppSpacing.sm),
            const MedicalRecordCard(title: 'ECG Report', category: 'Reports', date: '05 June 2026'),
            const SizedBox(height: AppSpacing.sm),
            const MedicalRecordCard(title: 'Chest X-Ray', category: 'Reports', date: '29 May 2026'),
            const SizedBox(height: AppSpacing.sm),
            const MedicalRecordCard(title: 'Prescription', category: 'Prescriptions', date: '20 May 2026'),
            const SizedBox(height: AppSpacing.xl),

            // Section 3: Categories
            const SectionHeader(title: 'Categories'),
            const CategoryCard(title: 'Lab Reports', fileCount: '3', icon: Icons.science),
            const SizedBox(height: AppSpacing.sm),
            const CategoryCard(title: 'Prescriptions', fileCount: '6', icon: Icons.medication),
            const SizedBox(height: AppSpacing.sm),
            const CategoryCard(title: 'Medical Certificates', fileCount: '2', icon: Icons.verified),
            const SizedBox(height: AppSpacing.sm),
            const CategoryCard(title: 'Vaccinations', fileCount: '1', icon: Icons.health_and_safety),
            const SizedBox(height: AppSpacing.sm),
            const CategoryCard(title: 'Hospital Records', fileCount: '12', icon: Icons.local_hospital),
            const SizedBox(height: AppSpacing.xl),

            // Section 4: Recent OCR History
            const SectionHeader(title: 'Recent OCR History'),
            const OcrHistoryCard(title: 'Prescription Scan', status: 'Medicine Successfully Detected'),
            const SizedBox(height: AppSpacing.sm),
            const OcrHistoryCard(title: 'Blood Report Scan', status: 'Health Metrics Extracted'),
            const SizedBox(height: AppSpacing.sm),
            const OcrHistoryCard(title: 'ECG Scan', status: 'Analysis Completed'),
            const SizedBox(height: AppSpacing.xl),

            // Section 5: AI Analysis Status
            const SectionHeader(title: 'AI Analysis Status'),
            const InformationCard(
              title: 'Ready for Analysis',
              description: 'Your uploaded reports are ready for future AI analysis.\n\nThis module will automatically summarize reports after backend integration.',
            ),
            const SizedBox(height: AppSpacing.xl),

            // Bottom Actions
            PrimaryButton(text: 'Upload Document', onPressed: () {}),
            const SizedBox(height: AppSpacing.md),
            SecondaryButton(text: 'Scan Prescription', onPressed: () {}),
            const SizedBox(height: AppSpacing.md),
            OutlinedButtonWidget(text: 'Back to Family & Caregivers', onPressed: () => context.pop()),
            
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}
