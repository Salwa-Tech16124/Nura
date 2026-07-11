import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_spacing.dart';
import '../../widgets/layout/page_container.dart';
import 'widgets/profile_header_card.dart';
import 'widgets/personal_info_card.dart';
import 'widgets/contact_profile_card.dart';
import 'widgets/quick_action_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.lg, bottom: AppSpacing.sm),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F1F5), // Light sky-blue neobrutalist backdrop
      appBar: AppBar(
        title: const Text(
          'My Profile', 
          style: TextStyle(
            color: Colors.black, 
            fontWeight: FontWeight.w900, 
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => context.go('/home'),
        ),
      ),
      body: PageContainer(
        child: ScrollablePageLayout(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppSpacing.sm),
            const Text(
              'Manage your personal information and healthcare profile.', 
              style: TextStyle(
                color: Colors.black87, 
                fontSize: 14, 
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Section 1: Profile Card (Vibrant Cyan)
            ProfileHeaderCard(
              name: 'Sarah Jenkins',
              age: '34 Years',
              gender: 'Female',
              bloodGroup: 'O+',
              onEdit: () {},
            ),
            const SizedBox(height: AppSpacing.xl),

            // Section 2: Personal Information (Lilac background)
            _buildSectionHeader('Personal Information'),
            const PersonalInfoCard(
              backgroundColor: Color(0xFFE5D5FF), // Lilac
              infoData: {
                'Phone Number': '+1 234 567 8900',
                'Email': 'sarah.jenkins@example.com',
                'Date of Birth': '12 May 1992',
                'Height': '168 cm',
                'Weight': '62 kg',
                'Address': '123 Health Ave, NY 10001',
              },
            ),
            const SizedBox(height: AppSpacing.xl),

            // Section 3: Health Information (Soft Pink background)
            _buildSectionHeader('Health Information'),
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
            _buildSectionHeader('Emergency Contacts'),
            ContactProfileCard(
              name: 'Sarah Doe',
              relationship: 'Daughter',
              phoneNumber: '+1 987 654 3210',
              onCall: () {},
            ),
            const SizedBox(height: AppSpacing.md),
            ContactProfileCard(
              name: 'Mike Doe',
              relationship: 'Son',
              phoneNumber: '+1 555 123 4567',
              onCall: () {},
            ),
            const SizedBox(height: AppSpacing.xl),

            // Section 5: Quick Actions (White with outlined pastel icon dots)
            _buildSectionHeader('Quick Actions'),
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
                border: Border.all(color: Colors.black, width: 1.8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(2, 4),
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
                onPressed: () {},
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
                border: Border.all(color: Colors.black, width: 1.8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(2, 4),
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
                onPressed: () {},
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
