import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../widgets/layout/page_container.dart';
import '../../widgets/buttons.dart';
import '../../widgets/navigation.dart';
import '../../features/family/providers/family_provider.dart';
import '../../features/family/models/family_member.dart';
import 'widgets/permission_tile.dart';
import 'widgets/activity_timeline_card.dart';

class FamilyCaregiversScreen extends ConsumerStatefulWidget {
  const FamilyCaregiversScreen({super.key});

  @override
  ConsumerState<FamilyCaregiversScreen> createState() =>
      _FamilyCaregiversScreenState();
}

class _FamilyCaregiversScreenState
    extends ConsumerState<FamilyCaregiversScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(familyProvider.notifier).load());
  }

  // ---- Add Member Dialog ----
  void _showAddMemberDialog() {
    final nameCtrl = TextEditingController();
    final relCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Family Member',
            style: TextStyle(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                hintText: 'e.g. John Doe',
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: relCtrl,
              decoration: const InputDecoration(
                labelText: 'Relationship',
                hintText: 'e.g. Son, Daughter',
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: phoneCtrl,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                hintText: 'e.g. +1 555-0199',
              ),
              keyboardType: TextInputType.phone,
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
              final name = nameCtrl.text.trim();
              final rel = relCtrl.text.trim();
              final phone = phoneCtrl.text.trim();
              if (name.isNotEmpty && rel.isNotEmpty && phone.isNotEmpty) {
                ref.read(familyProvider.notifier).add(
                      FamilyMember(
                        name: name,
                        relationship: rel,
                        phoneNumber: phone,
                      ),
                    );
                Navigator.of(ctx).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Family member added successfully!')),
                );
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  // ---- Member Card ----
  Widget _buildMemberCard(
      FamilyMember member, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF121625) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
            color: isDark ? Colors.white24 : Colors.black, width: 1.8),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.white10 : Colors.black,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFD3B6FC),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 1.8),
            ),
            child: Center(
              child: Text(
                member.name.isNotEmpty ? member.name[0].toUpperCase() : '?',
                style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                    color: Colors.black),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  '${member.relationship} · ${member.phoneNumber}',
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark ? Colors.white60 : Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          if (member.id != null)
            IconButton(
              icon: Icon(Icons.delete_outline,
                  color: isDark ? Colors.white54 : Colors.black54),
              onPressed: () {
                ref.read(familyProvider.notifier).delete(member.id!);
              },
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final familyState = ref.watch(familyProvider);

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF0A0C16) : AppColors.background,
      appBar: AppBar(
        title: Text('Family & Caregivers',
            style: AppTypography.h2
                .copyWith(color: isDark ? Colors.white : Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new,
              color: isDark ? Colors.white : Colors.black, size: 20),
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
              style: AppTypography.bodyLarge.copyWith(
                  color:
                      isDark ? Colors.white70 : AppColors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Section: Family Members (from backend)
            const SectionHeader(title: 'Family Members'),

            if (familyState.isLoading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (familyState.error != null && familyState.members.isEmpty)
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF121625) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: isDark ? Colors.white24 : Colors.black,
                      width: 1.8),
                ),
                child: Text(
                  'Could not load family members. Pull to refresh.',
                  style: TextStyle(
                      color: isDark ? Colors.white70 : Colors.black54,
                      fontWeight: FontWeight.w600),
                ),
              )
            else if (familyState.members.isEmpty)
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF121625) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: isDark ? Colors.white24 : Colors.black,
                      width: 1.8),
                ),
                child: Text(
                  'No family members added yet. Tap "Add Family Member" below.',
                  style: TextStyle(
                      color: isDark ? Colors.white70 : Colors.black54,
                      fontWeight: FontWeight.w600),
                ),
              )
            else
              ...familyState.members.map(
                  (m) => _buildMemberCard(m, isDark)),

            const SizedBox(height: AppSpacing.xl),

            // Section: Permissions (static UI)
            const SectionHeader(title: 'Permissions'),
            PermissionTile(
                title: 'Share Health Reports',
                isEnabled: true,
                onChanged: (val) {}),
            const SizedBox(height: AppSpacing.sm),
            PermissionTile(
                title: 'Receive SOS Alerts',
                isEnabled: true,
                onChanged: (val) {}),
            const SizedBox(height: AppSpacing.sm),
            PermissionTile(
                title: 'Medicine Notifications',
                isEnabled: true,
                onChanged: (val) {}),
            const SizedBox(height: AppSpacing.sm),
            PermissionTile(
                title: 'Live Location Sharing',
                isEnabled: true,
                onChanged: (val) {}),
            const SizedBox(height: AppSpacing.xl),

            // Section: Recent Activity (static UI)
            const SectionHeader(title: 'Recent Activity'),
            const ActivityTimelineCard(
                time: 'Yesterday',
                description: 'Health Report Shared with Caregiver'),
            const SizedBox(height: AppSpacing.sm),
            const ActivityTimelineCard(
                time: '2 Days Ago',
                description: 'SOS Test Completed Successfully'),
            const SizedBox(height: AppSpacing.sm),
            const ActivityTimelineCard(
                time: 'Last Week',
                description: 'Medicine Reminder Shared'),
            const SizedBox(height: AppSpacing.xl),

            // Bottom Actions
            PrimaryButton(
              text: 'Add Family Member',
              onPressed: _showAddMemberDialog,
            ),
            const SizedBox(height: AppSpacing.md),
            SecondaryButton(
              text: 'Refresh',
              onPressed: () => ref.read(familyProvider.notifier).load(),
            ),
            const SizedBox(height: AppSpacing.md),
            OutlinedButtonWidget(
                text: 'Back to Health Profile',
                onPressed: () => context.pop()),

            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}
