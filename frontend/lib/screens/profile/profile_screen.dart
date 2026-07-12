import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/providers/theme_provider.dart';
import '../../widgets/layout/page_container.dart';
import 'widgets/profile_header_card.dart';
import 'widgets/personal_info_card.dart';
import 'widgets/contact_profile_card.dart';
import 'widgets/quick_action_card.dart';
import '../../features/auth/providers/auth_state_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  Widget _buildSectionHeader(String title, {required bool isDark}) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.lg, bottom: AppSpacing.sm),
      child: Text(
        title,
        style: TextStyle(
          color: isDark ? Colors.white : Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final isDark = themeMode == ThemeMode.dark;
    final user = ref.watch(authStateProvider).user;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0A0C16) : const Color(0xFFE8F1F5), // Dynamic neobrutalist backdrop
      appBar: AppBar(
        title: Text(
          'My Profile', 
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black, 
            fontWeight: FontWeight.w900, 
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: isDark ? Colors.white : Colors.black, size: 20),
          onPressed: () => context.go('/home'),
        ),
      ),
      body: PageContainer(
        child: ScrollablePageLayout(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Manage your personal information and healthcare profile.', 
              style: TextStyle(
                color: isDark ? Colors.white70 : Colors.black87, 
                fontSize: 14, 
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Top Profile Banner Illustration Card
            Container(
              margin: const EdgeInsets.only(bottom: AppSpacing.lg),
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF121625) : Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: isDark ? Colors.white24 : Colors.black, width: 1.8),
                boxShadow: [
                  BoxShadow(
                    color: isDark ? Colors.white10 : Colors.black,
                    offset: const Offset(2, 4),
                  )
                ],
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/images/branding/profile_illustration.png',
                      height: 145,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Your Medical Profile Details',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'Connect with doctors, manage caregivers, and log history.',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white70 : Colors.black54,
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // Section 1: Profile Card (Vibrant Cyan)
            ProfileHeaderCard(
              name: user?.name ?? 'Sarah Jenkins',
              age: user?.age != null
                  ? '${user!.age} Years'
                  : '34 Years',
              gender: user?.gender ?? 'Female',
              bloodGroup: 'O+',
              onEdit: () => context.push('/health-profile'),
            ),
            const SizedBox(height: AppSpacing.xl),

            // Section 2: Personal Information (Lilac background)
            _buildSectionHeader('Personal Information', isDark: isDark),
            PersonalInfoCard(
              backgroundColor: const Color(0xFFE5D5FF), // Lilac
              infoData: {
                'Phone Number': user?.phoneNumber ?? '+1 234 567 8900',
                'Email': user?.email ?? 'sarah.jenkins@example.com',
                'Date of Birth': '12 May 1992',
                'Height': '168 cm',
                'Weight': '62 kg',
                'Address': '123 Health Ave, NY 10001',
              },
            ),
            const SizedBox(height: AppSpacing.xl),

            // Section 3: Health Information (Soft Pink background)
            _buildSectionHeader('Health Information', isDark: isDark),
            const PersonalInfoCard(
              backgroundColor: Color(0xFFFDCBE0), // Soft Pink
              infoData: {
                'Primary Health Conditions': 'Mild Hypertension',
                'Current Doctor': 'Dr. Anderson',
                'Hospital': 'City Care Hospital',
                'Emergency Blood Group': 'O+',
              },
            ),
            const SizedBox(height: AppSpacing.xl),

            // Section 4: Emergency Contacts (Vibrant Green background)
            _buildSectionHeader('Emergency Contacts', isDark: isDark),
            ContactProfileCard(
              name: user?.emergencyContact != null ? 'Primary Emergency' : 'Sarah Doe',
              relationship: user?.emergencyContact != null ? 'Contact' : 'Daughter',
              phoneNumber: user?.emergencyContact ?? '+1 987 654 3210',
              onCall: () {
                final phone = user?.emergencyContact ?? '+1 987 654 3210';
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Calling $phone...'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
            ),
            if (user?.emergencyContact == null) ...[
              const SizedBox(height: AppSpacing.md),
              ContactProfileCard(
                name: 'Mike Doe',
                relationship: 'Son',
                phoneNumber: '+1 555 123 4567',
                onCall: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Calling Mike Doe (+1 555 123 4567)...'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
            ],
            const SizedBox(height: AppSpacing.xl),

            // Section 5: Quick Actions (White with outlined pastel icon dots)
            _buildSectionHeader('Quick Actions', isDark: isDark),
            
            // Dynamic Theme Mode Switch Action
            QuickActionCard(
              title: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode', 
              icon: isDark ? Icons.light_mode : Icons.dark_mode, 
              iconBgColor: isDark ? const Color(0xFFFED782) : const Color(0xFF37474F),
              onTap: () {
                ref.read(themeModeProvider.notifier).state = isDark ? ThemeMode.light : ThemeMode.dark;
              },
            ),
            const SizedBox(height: AppSpacing.md),

            QuickActionCard(
              title: 'Health Profile', 
              icon: Icons.health_and_safety, 
              iconBgColor: const Color(0xFFFED782), // Yellow
              onTap: () => context.push('/health-profile'),
            ),
            const SizedBox(height: AppSpacing.md),
            QuickActionCard(
              title: 'Family & Caregivers', 
              icon: Icons.family_restroom, 
              iconBgColor: const Color(0xFFC2F3F8), // Cyan
              onTap: () => context.push('/family-caregivers'),
            ),
            const SizedBox(height: AppSpacing.md),
            QuickActionCard(
              title: 'Medical Records', 
              icon: Icons.folder, 
              iconBgColor: const Color(0xFFC3F3C0), // Green
              onTap: () => context.push('/medical-records'),
            ),
            const SizedBox(height: AppSpacing.md),
            QuickActionCard(
              title: 'Settings', 
              icon: Icons.settings, 
              iconBgColor: const Color(0xFFE5D5FF), // Lilac
              onTap: () => context.push('/settings-preferences'),
            ),
            const SizedBox(height: AppSpacing.md),
            QuickActionCard(
              title: 'Privacy & Security', 
              icon: Icons.security, 
              iconBgColor: const Color(0xFFFDCBE0), // Pink
              onTap: () => context.push('/privacy-security'),
            ),
            const SizedBox(height: AppSpacing.md),
            QuickActionCard(
              title: 'Help & Support', 
              icon: Icons.help_outline, 
              iconBgColor: const Color(0xFFFED782), // Yellow
              onTap: () => context.push('/about-nura'),
            ),
            const SizedBox(height: AppSpacing.xxl),

            // Bottom Actions (Neobrutalist solid buttons with shadows)
            // 1. Edit Profile Button
            Container(
              width: double.infinity,
              height: 52,
              decoration: BoxDecoration(
                color: const Color(0xFFC2F3F8), // Cyan neobrutalist
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: isDark ? Colors.white24 : Colors.black, width: 1.8),
                boxShadow: [
                  BoxShadow(
                    color: isDark ? Colors.white10 : Colors.black,
                    offset: const Offset(2, 4),
                  ),
                ],
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                onPressed: () => context.push('/health-profile'),
                child: const Text(
                  'Edit Profile',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            // 2. Logout Button
            Container(
              width: double.infinity,
              height: 52,
              decoration: BoxDecoration(
                color: const Color(0xFFFDCBE0), // Pink neobrutalist
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: isDark ? Colors.white24 : Colors.black, width: 1.8),
                boxShadow: [
                  BoxShadow(
                    color: isDark ? Colors.white10 : Colors.black,
                    offset: const Offset(2, 4),
                  ),
                ],
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                onPressed: () async {
                  await ref.read(authStateProvider.notifier).logout();
                  if (context.mounted) {
                    context.go('/login');
                  }
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}
