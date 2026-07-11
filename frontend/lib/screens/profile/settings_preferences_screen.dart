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
import '../../widgets/navigation.dart';

class SettingsPreferencesScreen extends StatelessWidget {
  const SettingsPreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Settings & Preferences', style: AppTypography.h2),
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: false,
      ),
      body: PageContainer(
        child: ScrollablePageLayout(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppSpacing.sm),
            Text('Customize your NURA experience.', style: AppTypography.bodyLarge.copyWith(color: AppColors.textSecondary)),
            const SizedBox(height: AppSpacing.lg),

            // Section 1: Notifications
            const SectionHeader(title: 'Notifications'),
            const SettingsSectionCard(
              children: [
                PreferenceTile(title: 'Medicine Reminders', isToggle: true, toggleValue: true),
                PreferenceTile(title: 'Health Alerts', isToggle: true, toggleValue: true),
                PreferenceTile(title: 'SOS Notifications', isToggle: true, toggleValue: true),
                PreferenceTile(title: 'Appointment Reminders', isToggle: true, toggleValue: true),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),

            // Section 2: Language & Accessibility
            const SectionHeader(title: 'Language & Accessibility'),
            const SettingsSectionCard(
              children: [
                PreferenceTile(title: 'Language', value: 'English'),
                PreferenceTile(title: 'Font Size', value: 'Medium'),
                PreferenceTile(title: 'Voice Assistant Language', value: 'English'),
                PreferenceTile(title: 'Accessibility Mode', value: 'Enabled'),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),

            // Section 3: Appearance
            const SectionHeader(title: 'Appearance'),
            const SettingsSectionCard(
              children: [
                PreferenceTile(title: 'Theme', value: 'Light Mode'),
                PreferenceTile(title: 'Color Theme', value: 'NURA Blue'),
                PreferenceTile(title: 'Animations', value: 'Enabled'),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),

            // Section 4: Voice Assistant Preferences
            const SectionHeader(title: 'Voice Assistant Preferences'),
            const SettingsSectionCard(
              children: [
                PreferenceTile(title: 'Voice Speed', value: 'Normal'),
                PreferenceTile(title: 'Voice Gender', value: 'Female'),
                PreferenceTile(title: 'Speech Feedback', value: 'Enabled'),
                PreferenceTile(title: 'Wake Word', value: '"NURA"'),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),

            // Section 5: AI Preferences
            const SectionHeader(title: 'AI Preferences'),
            const SettingsSectionCard(
              children: [
                PreferenceTile(title: 'AI Health Suggestions', value: 'Enabled'),
                PreferenceTile(title: 'Diet Recommendations', value: 'Enabled'),
                PreferenceTile(title: 'Medication Suggestions', value: 'Enabled'),
                PreferenceTile(title: 'Health Report Generation', value: 'Automatic'),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),

            // Section 6: General Settings
            const SectionHeader(title: 'General Settings'),
            const SettingsSectionCard(
              children: [
                PreferenceTile(title: 'Auto Backup', isToggle: true, toggleValue: true),
                PreferenceTile(title: 'Sync over Wi-Fi Only', isToggle: true, toggleValue: true),
                PreferenceTile(title: 'Automatic Updates', isToggle: true, toggleValue: true),
                PreferenceTile(title: 'Clear Cache', value: '520 MB'),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),

            // Section 7: Application Information
            const SectionHeader(title: 'Application Information'),
            const SettingsSectionCard(
              children: [
                PreferenceTile(title: 'Version', value: '1.0.0'),
                PreferenceTile(title: 'Build', value: 'Hackathon MVP'),
                PreferenceTile(title: 'Developer', value: 'Team NURA'),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),

            // Bottom Actions
            PrimaryButton(text: 'Save Preferences', onPressed: () {}),
            const SizedBox(height: AppSpacing.md),
            SecondaryButton(text: 'Reset Settings', onPressed: () {}),
            const SizedBox(height: AppSpacing.md),
            OutlinedButtonWidget(text: 'Back to Medical Records', onPressed: () => context.pop()),
            
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}
