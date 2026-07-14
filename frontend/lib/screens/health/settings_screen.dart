import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/navigation.dart';
import '../../widgets/layout/page_container.dart';
import '../../widgets/misc.dart';
import '../../core/theme/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0A0C16) : AppColors.background,
      appBar: const CustomAppBar(title: 'Local Database'),
      body: PageContainer(
        child: ScrollablePageLayout(
          children: [
            SettingTile(
              title: 'Data Sync',
              subtitle: '(Offline First)',
              icon: Icons.sync,
              onTap: () {},
              trailing: Switch(value: true, onChanged: (v) {}, activeColor: AppColors.primary),
            ),
            const CustomDivider(),
            SettingTile(
              title: 'Encryption Status',
              subtitle: 'Secured',
              icon: Icons.lock,
              onTap: () {},
              trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
            ),
            const CustomDivider(),
            SettingTile(
              title: 'Database Backup',
              subtitle: '(Last backup: 1 hr ago)',
              icon: Icons.storage,
              onTap: () {},
              trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
