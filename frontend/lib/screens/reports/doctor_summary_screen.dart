import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../widgets/layout/page_container.dart';
import '../../widgets/buttons.dart';
import '../../widgets/misc.dart';
import '../../widgets/cards.dart';
import 'widgets/stat_card.dart';
import 'widgets/observation_card.dart';
import 'widgets/patient_info_card.dart';
import 'widgets/attachment_card.dart';
import '../../widgets/navigation.dart';

class DoctorSummaryScreen extends StatelessWidget {
  const DoctorSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Doctor Summary', style: AppTypography.h2),
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: false,
      ),
      body: PageContainer(
        child: ScrollablePageLayout(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppSpacing.sm),
            Text('A concise overview of your recent health records.', style: AppTypography.bodyLarge.copyWith(color: AppColors.textSecondary)),
            const SizedBox(height: AppSpacing.lg),

            // Section 1: Patient Information
            const SectionHeader(title: 'Patient Information'),
            const PatientInfoCard(),
            const SizedBox(height: AppSpacing.xl),

            // Section 2: Current Health Status
            const SectionHeader(title: 'Current Health Status'),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: AppSpacing.md,
              crossAxisSpacing: AppSpacing.md,
              childAspectRatio: 1.5,
              children: const [
                StatCard(title: 'Health Score', value: '90 / 100', icon: Icons.health_and_safety),
                StatCard(title: 'Blood Pressure', value: '120 / 80', icon: Icons.monitor_heart),
                StatCard(title: 'Blood Sugar', value: '105 mg/dL', icon: Icons.water_drop),
                StatCard(title: 'Heart Rate', value: '74 BPM', icon: Icons.favorite),
                StatCard(title: 'Weight', value: '72 kg', icon: Icons.fitness_center),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),

            // Section 3: Current Medications
            const SectionHeader(title: 'Current Medications'),
            const MedicineCard(name: 'Metformin 500 mg', dosage: 'Morning & Night', time: ''),
            const SizedBox(height: AppSpacing.sm),
            const MedicineCard(name: 'Telmisartan 40 mg', dosage: 'Night', time: ''),
            const SizedBox(height: AppSpacing.sm),
            const MedicineCard(name: 'Vitamin D3', dosage: 'Weekly', time: ''),
            const SizedBox(height: AppSpacing.xl),

            // Section 4: Health Observations
            const SectionHeader(title: 'Health Observations'),
            const ObservationCard(text: 'Medicine adherence has remained excellent.'),
            const SizedBox(height: AppSpacing.sm),
            const ObservationCard(text: 'Blood pressure remained stable.'),
            const SizedBox(height: AppSpacing.sm),
            const ObservationCard(text: 'Walking activity improved.'),
            const SizedBox(height: AppSpacing.sm),
            const ObservationCard(text: 'Heart rate remained within normal range.'),
            const SizedBox(height: AppSpacing.xl),

            // Section 5: Doctor Notes
            const SectionHeader(title: 'Doctor Notes'),
            const InformationCard(
              title: 'Important Note',
              description: 'This summary is generated from your recent health records.\n\nPlease discuss any concerns with your healthcare provider.\n\nThis report is intended to assist the consultation process and is not a medical diagnosis.',
            ),
            const SizedBox(height: AppSpacing.xl),

            // Section 6: Attachments
            const SectionHeader(title: 'Attachments'),
            const AttachmentCard(title: 'Weekly Health Report', date: 'Oct 05 - Oct 12'),
            const SizedBox(height: AppSpacing.sm),
            const AttachmentCard(title: 'Monthly Health Report', date: 'September 2026'),
            const SizedBox(height: AppSpacing.xl),

            // Bottom Actions
            PrimaryButton(text: 'Share Report', onPressed: () => context.push('/share-report')),
            const SizedBox(height: AppSpacing.md),
            SecondaryButton(text: 'Download PDF', onPressed: () {}),
            const SizedBox(height: AppSpacing.md),
            OutlinedButtonWidget(text: 'Back to AI Summary', onPressed: () => context.pop()),
            
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}
