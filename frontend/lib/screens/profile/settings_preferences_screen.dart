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

class SettingsPreferencesScreen extends StatefulWidget {
  const SettingsPreferencesScreen({super.key});

  @override
  State<SettingsPreferencesScreen> createState() => _SettingsPreferencesScreenState();
}

class _SettingsPreferencesScreenState extends State<SettingsPreferencesScreen> {
  // Language & Accessibility State
  String _language = 'English';
  String _fontSize = 'Medium';
  String _voiceLanguage = 'English';
  String _accessibilityMode = 'Enabled';

  // Appearance State
  String _theme = 'Light Mode';
  String _colorTheme = 'NURA Blue';
  String _animations = 'Enabled';

  // Voice Assistant preferences
  String _voiceSpeed = 'Normal';
  String _voiceGender = 'Female';
  String _speechFeedback = 'Enabled';
  String _wakeWord = '"NURA"';

  // AI preferences
  String _aiHealthSuggestions = 'Enabled';
  String _medicationSuggestions = 'Enabled';
  String _reportGeneration = 'Automatic';

  // Helper method to show single selection dialogs
  void _showSingleSelectDialog({
    required String title,
    required List<String> options,
    required String currentValue,
    required ValueChanged<String> onSelected,
  }) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: options.map((option) {
                return RadioListTile<String>(
                  title: Text(option),
                  value: option,
                  groupValue: currentValue,
                  onChanged: (value) {
                    if (value != null) {
                      onSelected(value);
                      Navigator.of(ctx).pop();
                    }
                  },
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0A0C16) : AppColors.background,
      appBar: AppBar(
        title: Text('Settings & Preferences', style: AppTypography.h2.copyWith(color: isDark ? Colors.white : Colors.black)),
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
              'Customize your NURA experience.', 
              style: AppTypography.bodyLarge.copyWith(color: isDark ? Colors.white70 : AppColors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Section 1: Notifications
            const SectionHeader(title: 'Notifications'),
            const SettingsSectionCard(
              children: [
                PreferenceTile(title: 'Medicine Reminders', isToggle: true, toggleValue: true),
                PreferenceTile(title: 'Health Alerts', isToggle: true, toggleValue: true),
                PreferenceTile(title: 'SOS Notifications', isToggle: true, toggleValue: true),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),

            // Section 2: Language & Accessibility
            const SectionHeader(title: 'Language & Accessibility'),
            SettingsSectionCard(
              children: [
                PreferenceTile(
                  title: 'Language', 
                  value: _language,
                  onTap: () => _showSingleSelectDialog(
                    title: 'Select Language',
                    options: ['English', 'Spanish', 'Hindi', 'French', 'German'],
                    currentValue: _language,
                    onSelected: (val) => setState(() => _language = val),
                  ),
                ),
                PreferenceTile(
                  title: 'Font Size', 
                  value: _fontSize,
                  onTap: () => _showSingleSelectDialog(
                    title: 'Select Font Size',
                    options: ['Small', 'Medium', 'Large', 'Extra Large'],
                    currentValue: _fontSize,
                    onSelected: (val) => setState(() => _fontSize = val),
                  ),
                ),
                PreferenceTile(
                  title: 'Voice Assistant Language', 
                  value: _voiceLanguage,
                  onTap: () => _showSingleSelectDialog(
                    title: 'Voice Assistant Language',
                    options: ['English', 'Spanish', 'Hindi', 'French'],
                    currentValue: _voiceLanguage,
                    onSelected: (val) => setState(() => _voiceLanguage = val),
                  ),
                ),
                PreferenceTile(
                  title: 'Accessibility Mode', 
                  value: _accessibilityMode,
                  onTap: () => _showSingleSelectDialog(
                    title: 'Accessibility Mode',
                    options: ['Enabled', 'Disabled'],
                    currentValue: _accessibilityMode,
                    onSelected: (val) => setState(() => _accessibilityMode = val),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),

            // Section 3: Appearance
            const SectionHeader(title: 'Appearance'),
            SettingsSectionCard(
              children: [
                PreferenceTile(
                  title: 'Theme', 
                  value: _theme,
                  onTap: () => _showSingleSelectDialog(
                    title: 'Select Theme',
                    options: ['Light Mode', 'Dark Mode', 'System Default'],
                    currentValue: _theme,
                    onSelected: (val) => setState(() => _theme = val),
                  ),
                ),
                PreferenceTile(
                  title: 'Color Theme', 
                  value: _colorTheme,
                  onTap: () => _showSingleSelectDialog(
                    title: 'Select Color Theme',
                    options: ['NURA Blue', 'Emerald Green', 'Sunset Orange'],
                    currentValue: _colorTheme,
                    onSelected: (val) => setState(() => _colorTheme = val),
                  ),
                ),
                PreferenceTile(
                  title: 'Animations', 
                  value: _animations,
                  onTap: () => _showSingleSelectDialog(
                    title: 'Animations',
                    options: ['Enabled', 'Disabled'],
                    currentValue: _animations,
                    onSelected: (val) => setState(() => _animations = val),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),

            // Section 4: Voice Assistant Preferences
            const SectionHeader(title: 'Voice Assistant Preferences'),
            SettingsSectionCard(
              children: [
                PreferenceTile(
                  title: 'Voice Speed', 
                  value: _voiceSpeed,
                  onTap: () => _showSingleSelectDialog(
                    title: 'Voice Speed',
                    options: ['Slow', 'Normal', 'Fast'],
                    currentValue: _voiceSpeed,
                    onSelected: (val) => setState(() => _voiceSpeed = val),
                  ),
                ),
                PreferenceTile(
                  title: 'Voice Gender', 
                  value: _voiceGender,
                  onTap: () => _showSingleSelectDialog(
                    title: 'Voice Gender',
                    options: ['Male', 'Female'],
                    currentValue: _voiceGender,
                    onSelected: (val) => setState(() => _voiceGender = val),
                  ),
                ),
                PreferenceTile(
                  title: 'Speech Feedback', 
                  value: _speechFeedback,
                  onTap: () => _showSingleSelectDialog(
                    title: 'Speech Feedback',
                    options: ['Enabled', 'Disabled'],
                    currentValue: _speechFeedback,
                    onSelected: (val) => setState(() => _speechFeedback = val),
                  ),
                ),
                PreferenceTile(
                  title: 'Wake Word', 
                  value: _wakeWord,
                  onTap: () => _showSingleSelectDialog(
                    title: 'Wake Word',
                    options: ['"NURA"', '"Hey NURA"', '"Computer"'],
                    currentValue: _wakeWord,
                    onSelected: (val) => setState(() => _wakeWord = val),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),

            // Section 5: AI Preferences
            const SectionHeader(title: 'AI Preferences'),
            SettingsSectionCard(
              children: [
                PreferenceTile(
                  title: 'AI Health Suggestions', 
                  value: _aiHealthSuggestions,
                  onTap: () => _showSingleSelectDialog(
                    title: 'AI Health Suggestions',
                    options: ['Enabled', 'Disabled'],
                    currentValue: _aiHealthSuggestions,
                    onSelected: (val) => setState(() => _aiHealthSuggestions = val),
                  ),
                ),
                PreferenceTile(
                  title: 'Medication Suggestions', 
                  value: _medicationSuggestions,
                  onTap: () => _showSingleSelectDialog(
                    title: 'Medication Suggestions',
                    options: ['Enabled', 'Disabled'],
                    currentValue: _medicationSuggestions,
                    onSelected: (val) => setState(() => _medicationSuggestions = val),
                  ),
                ),
                PreferenceTile(
                  title: 'Health Report Generation', 
                  value: _reportGeneration,
                  onTap: () => _showSingleSelectDialog(
                    title: 'Health Report Generation',
                    options: ['Automatic', 'Manual', 'Weekly Only'],
                    currentValue: _reportGeneration,
                    onSelected: (val) => setState(() => _reportGeneration = val),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),

            // Section 6: General Settings
            const SectionHeader(title: 'General Settings'),
            SettingsSectionCard(
              children: [
                const PreferenceTile(title: 'Auto Backup', isToggle: true, toggleValue: true),
                const PreferenceTile(title: 'Sync over Wi-Fi Only', isToggle: true, toggleValue: true),
                const PreferenceTile(title: 'Automatic Updates', isToggle: true, toggleValue: true),
                PreferenceTile(
                  title: 'Clear Cache', 
                  value: '520 MB',
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Clear Cache'),
                        content: const Text('Are you sure you want to clear 520 MB of cached files?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(ctx).pop(),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Cache cleared successfully!')),
                              );
                            },
                            child: const Text('Clear'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
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
            PrimaryButton(
              text: 'Save Preferences', 
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Preferences saved successfully!')),
                );
              },
            ),
            const SizedBox(height: AppSpacing.md),
            SecondaryButton(
              text: 'Reset Settings', 
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Reset Settings'),
                    content: const Text('Restore all NURA settings and parameters to their default values?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          setState(() {
                            _language = 'English';
                            _fontSize = 'Medium';
                            _voiceLanguage = 'English';
                            _accessibilityMode = 'Enabled';
                            _theme = 'Light Mode';
                            _colorTheme = 'NURA Blue';
                            _animations = 'Enabled';
                            _voiceSpeed = 'Normal';
                            _voiceGender = 'Female';
                            _speechFeedback = 'Enabled';
                            _wakeWord = '"NURA"';
                            _aiHealthSuggestions = 'Enabled';
                            _medicationSuggestions = 'Enabled';
                            _reportGeneration = 'Automatic';
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('All settings reset to defaults.')),
                          );
                        },
                        child: const Text('Reset'),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: AppSpacing.md),
            OutlinedButtonWidget(text: 'Back to Medical Records', onPressed: () => context.pop()),
            
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}
