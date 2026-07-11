import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../widgets/layout/page_container.dart';
import '../../widgets/buttons.dart';
import '../../widgets/misc.dart';
import 'widgets/settings_section_card.dart';
import 'widgets/preference_tile.dart';
import 'widgets/permission_card.dart';
import 'widgets/security_activity_tile.dart';
import 'widgets/security_status_card.dart';
import 'widgets/quick_action_card.dart';
import '../../widgets/navigation.dart';

class PrivacySecurityScreen extends StatelessWidget {
  const PrivacySecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Privacy & Security', style: AppTypography.h2),
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: false,
      ),
      body: PageContainer(
        child: ScrollablePageLayout(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppSpacing.sm),
            Text('Protect your personal information and health data.', style: AppTypography.bodyLarge.copyWith(color: AppColors.textSecondary)),
            const SizedBox(height: AppSpacing.lg),

            // Section 1: Account Security
            const SectionHeader(title: 'Account Security'),
            const SettingsSectionCard(
              children: [
                PreferenceTile(title: 'Change Password', value: '20 Days Ago'),
                PreferenceTile(title: 'PIN Lock', value: 'Enabled'),
                PreferenceTile(title: 'Biometric Login', value: 'Fingerprint Enabled'),
                PreferenceTile(title: 'Two-Factor Authentication', value: 'Enabled'),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),

            // Section 2: Privacy Controls
            const SectionHeader(title: 'Privacy Controls'),
            const SettingsSectionCard(
              children: [
                PreferenceTile(title: 'Share Anonymous Analytics', isToggle: true, toggleValue: false),
                PreferenceTile(title: 'Allow AI Personalization', isToggle: true, toggleValue: true),
                PreferenceTile(title: 'Share Reports with Family', isToggle: true, toggleValue: true),
                PreferenceTile(title: 'Location Sharing during SOS', isToggle: true, toggleValue: true),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),

            // Section 3: App Permissions
            const SectionHeader(title: 'App Permissions'),
            const PermissionCard(title: 'Camera', icon: Icons.camera_alt),
            const SizedBox(height: AppSpacing.sm),
            const PermissionCard(title: 'Microphone', icon: Icons.mic),
            const SizedBox(height: AppSpacing.sm),
            const PermissionCard(title: 'Location', icon: Icons.location_on),
            const SizedBox(height: AppSpacing.sm),
            const PermissionCard(title: 'Notifications', icon: Icons.notifications),
            const SizedBox(height: AppSpacing.sm),
            const PermissionCard(title: 'Storage', icon: Icons.folder),
            const SizedBox(height: AppSpacing.xl),

            // Section 4: Data Management
            const SectionHeader(title: 'Data Management'),
            QuickActionCard(title: 'Download My Data', icon: Icons.download, onTap: () {}),
            const SizedBox(height: AppSpacing.sm),
            QuickActionCard(title: 'Delete Cache', icon: Icons.delete_outline, onTap: () {}),
            const SizedBox(height: AppSpacing.sm),
            QuickActionCard(title: 'Manage Storage', icon: Icons.storage, onTap: () {}),
            const SizedBox(height: AppSpacing.sm),
            QuickActionCard(title: 'Backup Status', icon: Icons.cloud_done, onTap: () {}),
            const SizedBox(height: AppSpacing.xl),

            // Section 5: Security Status
            const SectionHeader(title: 'Security Status'),
            const SecurityStatusCard(),
            const SizedBox(height: AppSpacing.xl),

            // Section 6: Recent Security Activity
            const SectionHeader(title: 'Recent Security Activity'),
            const SecurityActivityTile(time: 'Today', description: 'Fingerprint Login'),
            const SizedBox(height: AppSpacing.sm),
            const SecurityActivityTile(time: 'Yesterday', description: 'Password Verified'),
            const SizedBox(height: AppSpacing.sm),
            const SecurityActivityTile(time: '3 Days Ago', description: 'Successful Backup'),
            const SizedBox(height: AppSpacing.sm),
            const SecurityActivityTile(time: '1 Week Ago', description: 'Profile Updated'),
            const SizedBox(height: AppSpacing.xl),

            // Bottom Actions
            PrimaryButton(text: 'Save Security Settings', onPressed: () {}),
            const SizedBox(height: AppSpacing.md),
            SecondaryButton(text: 'Reset Security Settings', onPressed: () {}),
            const SizedBox(height: AppSpacing.md),
            OutlinedButtonWidget(text: 'Back to Settings', onPressed: () => context.pop()),
            
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}
