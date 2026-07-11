import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../widgets/layout/page_container.dart';
import '../../widgets/buttons.dart';
import '../../widgets/misc.dart';
import '../../widgets/cards.dart';
import 'widgets/medical_condition_card.dart';
import 'widgets/doctor_card.dart';
import 'widgets/medical_document_card.dart';
import 'widgets/medical_history_tile.dart';
import '../../widgets/navigation.dart';

class HealthProfileScreen extends StatelessWidget {
  const HealthProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Health Profile', style: AppTypography.h2),
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: false,
      ),
      body: PageContainer(
        child: ScrollablePageLayout(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppSpacing.sm),
            Text('Your complete medical information in one place.', style: AppTypography.bodyLarge.copyWith(color: AppColors.textSecondary)),
            const SizedBox(height: AppSpacing.lg),

            // Section 1: Health Overview
            const SectionHeader(title: 'Health Overview'),
            BaseCard(
              backgroundColor: AppColors.primaryLight,
              child: Column(
                children: [
                  _buildInfoRow('Health Status', 'Stable'),
                  const Divider(height: AppSpacing.md, color: AppColors.surface),
                  _buildInfoRow('Health Score', '90 / 100'),
                  const Divider(height: AppSpacing.md, color: AppColors.surface),
                  _buildInfoRow('Blood Group', 'O+'),
                  const Divider(height: AppSpacing.md, color: AppColors.surface),
                  _buildInfoRow('Medical ID', 'NURA-100245'),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            // Section 2: Medical Conditions
            const SectionHeader(title: 'Medical Conditions'),
            const MedicalConditionCard(condition: 'Type 2 Diabetes', status: 'Active', icon: Icons.coronavirus),
            const SizedBox(height: AppSpacing.sm),
            const MedicalConditionCard(condition: 'Hypertension', status: 'Active', icon: Icons.monitor_heart),
            const SizedBox(height: AppSpacing.sm),
            const MedicalConditionCard(condition: 'Vitamin D Deficiency', status: 'Active', icon: Icons.wb_sunny),
            const SizedBox(height: AppSpacing.xl),

            // Section 3: Allergies
            const SectionHeader(title: 'Allergies'),
            const MedicalConditionCard(condition: 'Penicillin', status: 'Active', icon: Icons.medication_liquid),
            const SizedBox(height: AppSpacing.sm),
            const MedicalConditionCard(condition: 'Peanuts', status: 'Active', icon: Icons.grass),
            const SizedBox(height: AppSpacing.sm),
            const MedicalConditionCard(condition: 'Dust Allergy', status: 'Active', icon: Icons.air),
            const SizedBox(height: AppSpacing.xl),

            // Section 4: Current Medications
            const SectionHeader(title: 'Current Medications'),
            const MedicineCard(name: 'Metformin 500 mg', dosage: 'Morning & Night', time: ''),
            const SizedBox(height: AppSpacing.sm),
            const MedicineCard(name: 'Telmisartan 40 mg', dosage: 'Night', time: ''),
            const SizedBox(height: AppSpacing.sm),
            const MedicineCard(name: 'Vitamin D3', dosage: 'Weekly', time: ''),
            const SizedBox(height: AppSpacing.xl),

            // Section 5: Medical History
            const SectionHeader(title: 'Medical History'),
            const MedicalHistoryTile(year: '2023', title: 'Routine Diabetes Checkup'),
            const SizedBox(height: AppSpacing.sm),
            const MedicalHistoryTile(year: '2024', title: 'Blood Pressure Monitoring'),
            const SizedBox(height: AppSpacing.sm),
            const MedicalHistoryTile(year: '2025', title: 'Annual Health Examination'),
            const SizedBox(height: AppSpacing.xl),

            // Section 6: Primary Doctor
            const SectionHeader(title: 'Primary Doctor'),
            const DoctorCard(
              name: 'Dr. Anderson',
              specialization: 'Cardiologist',
              hospital: 'City Care Hospital',
              phone: '+91 9876543210',
            ),
            const SizedBox(height: AppSpacing.xl),

            // Section 7: Health Documents
            const SectionHeader(title: 'Health Documents'),
            const MedicalDocumentCard(title: 'Blood Test Report', date: 'Oct 10, 2026'),
            const SizedBox(height: AppSpacing.sm),
            const MedicalDocumentCard(title: 'ECG Report', date: 'Sep 15, 2026'),
            const SizedBox(height: AppSpacing.sm),
            const MedicalDocumentCard(title: 'Prescription', date: 'Aug 20, 2026'),
            const SizedBox(height: AppSpacing.sm),
            const MedicalDocumentCard(title: 'Vaccination Record', date: 'Jan 01, 2026'),
            const SizedBox(height: AppSpacing.xl),

            // Bottom Actions
            PrimaryButton(text: 'Update Health Profile', onPressed: () {}),
            const SizedBox(height: AppSpacing.md),
            SecondaryButton(text: 'Back to Profile', onPressed: () => context.pop()),
            
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary)),
        Text(value, style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.bold, color: AppColors.primary)),
      ],
    );
  }
}
