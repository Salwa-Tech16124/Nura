import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../widgets/layout/page_container.dart';
import '../../widgets/buttons.dart';
import '../../widgets/misc.dart';
import 'widgets/caregiver_card.dart';
import 'widgets/family_member_card.dart';
import 'widgets/emergency_contact_card.dart';
import 'widgets/permission_tile.dart';
import 'widgets/activity_timeline_card.dart';
import '../../widgets/navigation.dart';

class FamilyCaregiversScreen extends StatelessWidget {
  const FamilyCaregiversScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Family & Caregivers', style: AppTypography.h2),
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: false,
      ),
      body: PageContainer(
        child: ScrollablePageLayout(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppSpacing.sm),
            Text('Manage the people who help care for your health.', style: AppTypography.bodyLarge.copyWith(color: AppColors.textSecondary)),
            const SizedBox(height: AppSpacing.lg),

            // Section 1: Primary Caregiver
            const SectionHeader(title: 'Primary Caregiver'),
            const CaregiverCard(
              name: 'Sarah Doe',
              relationship: 'Daughter',
              phone: '+91 9876543210',
            ),
            const SizedBox(height: AppSpacing.xl),

            // Section 2: Family Members
            const SectionHeader(title: 'Family Members'),
            const FamilyMemberCard(
              name: 'Mike Doe',
              relationship: 'Son',
              phone: '+91 9123456789',
            ),
            const SizedBox(height: AppSpacing.sm),
            const FamilyMemberCard(
              name: 'Emily Doe',
              relationship: 'Granddaughter',
              phone: '+91 9988776655',
            ),
            const SizedBox(height: AppSpacing.xl),

            // Section 3: Emergency Contacts
            const SectionHeader(title: 'Emergency Contacts'),
            const EmergencyContactCard(
              type: 'Doctor',
              name: 'Dr. Anderson',
              phone: '+91 9876543210',
            ),
            const SizedBox(height: AppSpacing.sm),
            const EmergencyContactCard(
              type: 'Neighbour',
              name: 'Robert Smith',
              phone: '+91 9988776611',
            ),
            const SizedBox(height: AppSpacing.sm),
            const EmergencyContactCard(
              type: 'Brother',
              name: 'James Doe',
              phone: '+91 9123456711',
            ),
            const SizedBox(height: AppSpacing.xl),

            // Section 4: Permissions
            const SectionHeader(title: 'Permissions'),
            PermissionTile(title: 'Share Health Reports', isEnabled: true, onChanged: (val) {}),
            const SizedBox(height: AppSpacing.sm),
            PermissionTile(title: 'Receive SOS Alerts', isEnabled: true, onChanged: (val) {}),
            const SizedBox(height: AppSpacing.sm),
            PermissionTile(title: 'Medicine Notifications', isEnabled: true, onChanged: (val) {}),
            const SizedBox(height: AppSpacing.sm),
            PermissionTile(title: 'Live Location Sharing', isEnabled: true, onChanged: (val) {}),
            const SizedBox(height: AppSpacing.xl),

            // Section 5: Recent Activity
            const SectionHeader(title: 'Recent Activity'),
            const ActivityTimelineCard(time: 'Yesterday', description: 'Health Report Shared with Sarah'),
            const SizedBox(height: AppSpacing.sm),
            const ActivityTimelineCard(time: '2 Days Ago', description: 'SOS Test Completed Successfully'),
            const SizedBox(height: AppSpacing.sm),
            const ActivityTimelineCard(time: 'Last Week', description: 'Medicine Reminder Shared'),
            const SizedBox(height: AppSpacing.xl),

            // Bottom Actions
            PrimaryButton(text: 'Add Family Member', onPressed: () {}),
            const SizedBox(height: AppSpacing.md),
            SecondaryButton(text: 'Edit Contacts', onPressed: () {}),
            const SizedBox(height: AppSpacing.md),
            OutlinedButtonWidget(text: 'Back to Health Profile', onPressed: () => context.pop()),
            
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}
