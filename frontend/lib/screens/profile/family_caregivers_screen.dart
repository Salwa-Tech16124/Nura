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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0A0C16) : AppColors.background,
      appBar: AppBar(
        title: Text('Family & Caregivers', style: AppTypography.h2.copyWith(color: isDark ? Colors.white : Colors.black)),
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
              'Manage the people who help care for your health.', 
              style: AppTypography.bodyLarge.copyWith(color: isDark ? Colors.white70 : AppColors.textSecondary),
            ),
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
            PrimaryButton(
              text: 'Add Family Member',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Add Family Member'),
                    content: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Full Name',
                            hintText: 'e.g. John Doe',
                          ),
                        ),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Relationship',
                            hintText: 'e.g. Son, Cousin',
                          ),
                        ),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            hintText: 'e.g. +1 555-0199',
                          ),
                        ),
                      ],
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
                            const SnackBar(content: Text('Caregiver invitation sent successfully!')),
                          );
                        },
                        child: const Text('Invite'),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: AppSpacing.md),
            SecondaryButton(
              text: 'Edit Contacts',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Contact editing is ready. Tap active cards to call or message!')),
                );
              },
            ),
            const SizedBox(height: AppSpacing.md),
            OutlinedButtonWidget(text: 'Back to Health Profile', onPressed: () => context.pop()),
            
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}
