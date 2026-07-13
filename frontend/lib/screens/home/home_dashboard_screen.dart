import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../widgets/layout/page_container.dart';
import '../../widgets/cards.dart';
import '../../widgets/navigation.dart';
import '../../widgets/buttons.dart';
import '../../widgets/misc.dart';
import '../../providers/auth_provider.dart';

class HomeDashboardScreen extends ConsumerStatefulWidget {
  const HomeDashboardScreen({super.key});

  @override
  ConsumerState<HomeDashboardScreen> createState() =>
      _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends ConsumerState<HomeDashboardScreen> {
  int _selectedMoodIndex = 2; // Default to "Calm"

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF3F0), // Premium light sage-green background
      body: PageContainer(
        padding: EdgeInsets.zero, // Zero padding to allow full edge-to-edge sheet curves
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              // Top Section (Header)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // Round user avatar with shadow
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(20),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage('assets/images/branding/nura_app_icon.png'),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ref.watch(currentUserProvider)?.name ?? 'Welcome!',
                              style: AppTypography.h3.copyWith(
                                color: const Color(0xFF1E244A),
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              'Patient',
                              style: AppTypography.bodySmall.copyWith(
                                color: Colors.black54,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // Notification bell with red dot badge
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(15),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const Icon(
                            Icons.notifications_none_outlined,
                            color: Color(0xFF1E244A),
                            size: 24,
                          ),
                          Positioned(
                            top: 12,
                            right: 12,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Colors.redAccent,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // "How do you feel today?" mood selector section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'How do you feel today?',
                      style: AppTypography.bodyLarge.copyWith(
                        color: const Color(0xFF1E244A),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    // Horizontal mood cards selector row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildMoodCard(0, 'Angry', const Color(0xFFFFECEB), Colors.redAccent),
                        _buildMoodCard(1, 'Sad', const Color(0xFFE3F2FD), Colors.blueAccent),
                        _buildMoodCard(2, 'Calm', const Color(0xFFFFFDE7), Colors.amber),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Bottom White content sheet (Self-care tabs and actions grid)
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(36),
                    topRight: Radius.circular(36),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Health score summary card
                    BaseCard(
                      backgroundColor: const Color(0xFF94B6FF), // Soft Blue score card
                      borderRadius: BorderRadius.circular(28),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Health Score',
                                style: AppTypography.bodyLarge.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Icon(Icons.trending_up, color: Colors.white),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            '92 / 100',
                            style: AppTypography.h1.copyWith(
                              color: Colors.white,
                              fontSize: 38,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Last Check-in: 2 hrs ago',
                                style: AppTypography.bodySmall.copyWith(
                                  color: Colors.white.withAlpha(200),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white.withAlpha(40),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'Excellent',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxl),

                    // Quick Actions
                    Text(
                      'Self-care',
                      style: AppTypography.h2.copyWith(
                        color: const Color(0xFF1E244A),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        _buildTabButton('Practices', true),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // 2x3 grid of premium action cards
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: AppSpacing.md,
                      crossAxisSpacing: AppSpacing.md,
                      childAspectRatio: 0.95,
                      children: [
                        _buildActionCard(
                          title: 'AI Health Timeline',
                          subtitle: 'Daily tracker',
                          bgColor: const Color(0xFFFBB584), // Orange/Peach
                          iconWidget: const Icon(Icons.coffee_outlined, size: 40, color: Color(0xFFE65100)),
                          onTap: () => context.go('/wellness'),
                        ),
                        _buildActionCard(
                          title: 'Medication',
                          subtitle: 'Schedule & logs',
                          bgColor: const Color(0xFF98BEF8), // Soft Blue
                          iconWidget: const SmileyStarWidget(),
                          onTap: () => context.go('/meds'),
                        ),
                        _buildActionCard(
                          title: 'Scan Prescription',
                          subtitle: 'Extract Rx details',
                          bgColor: const Color(0xFFD3B6FC), // Soft Purple
                          iconWidget: const Icon(Icons.qr_code_scanner_outlined, size: 40, color: Color(0xFF6A1B9A)),
                          onTap: () => context.go('/wellness'),
                        ),
                        _buildActionCard(
                          title: 'Wellness Logs',
                          subtitle: 'Vitals dashboard',
                          bgColor: const Color(0xFFA5E6BD), // Soft Green
                          iconWidget: const Icon(Icons.wb_sunny_outlined, size: 40, color: Color(0xFF2E7D32)),
                          onTap: () => context.go('/health'),
                        ),
                        _buildActionCard(
                          title: 'SOS Alert',
                          subtitle: 'Emergency contact',
                          bgColor: const Color(0xFFFFA2A2), // Soft Pink
                          iconWidget: const Icon(Icons.alarm, size: 40, color: Color(0xFFC62828)),
                          onTap: () => context.push('/sos-map'),
                        ),
                        _buildActionCard(
                          title: 'Health Reports',
                          subtitle: 'Weekly summary',
                          bgColor: const Color(0xFFF7EC9F), // Soft Yellow
                          iconWidget: const Icon(Icons.book_outlined, size: 40, color: Color(0xFFF57F17)),
                          onTap: () => context.push('/reports'),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xxl),

                    // Today's Schedule
                    const SectionHeader(title: "Today's Schedule", actionText: 'View All'),
                    _buildScheduleCard(
                      title: 'Lisinopril 10mg',
                      subtitle: '1 Pill',
                      time: '8:00 AM',
                      bgColor: const Color(0xFFE8F0FE), // Soft Blue
                      icon: Icons.medication_rounded,
                      iconColor: const Color(0xFF1A73E8),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _buildScheduleCard(
                      title: 'Symptom Check-in',
                      subtitle: 'Log current symptoms',
                      time: 'Pending',
                      bgColor: const Color(0xFFFFF9C4), // Soft Yellow
                      icon: Icons.edit_note_rounded,
                      iconColor: const Color(0xFFF57F17),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _buildScheduleCard(
                      title: 'Water Reminder',
                      subtitle: 'Drink 1 Glass',
                      time: 'Hourly',
                      bgColor: const Color(0xFFE2F1F8), // Soft Light Blue
                      icon: Icons.water_drop_rounded,
                      iconColor: const Color(0xFF0288D1),
                    ),
                    const SizedBox(height: AppSpacing.xxl),

                    // Wellness Insights Card
                    const SectionHeader(title: 'Wellness Insights'),
                    BaseCard(
                      backgroundColor: const Color(0xFFF3E8FF), // Soft Purple
                      borderRadius: BorderRadius.circular(24),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.auto_awesome,
                                color: Color(0xFF7B1FA2),
                                size: 22,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Wellness Summary',
                                  style: TextStyle(
                                    color: Color(0xFF1E244A),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.xs),
                                Text(
                                  'Your medication adherence has improved this week. Your blood pressure trends remain stable.',
                                  style: TextStyle(
                                    color: const Color(0xFF1E244A).withAlpha(180),
                                    fontSize: 14,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxl),

                    // Emergency SOS Button
                    const SectionHeader(title: 'Emergency'),
                    Container(
                      width: double.infinity,
                      height: 52,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        color: const Color(0xFFD32F2F), // Bright Premium Red
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFD32F2F).withAlpha(80),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
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
                        onPressed: () => context.push('/sos'),
                        child: const Text(
                          'Emergency SOS',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper builder for mood selection cards
  Widget _buildMoodCard(int index, String label, Color bgColor, Color themeColor) {
    bool isSelected = _selectedMoodIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedMoodIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 104,
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? themeColor : Colors.transparent,
            width: 2.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(isSelected ? 20 : 8),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            _buildMoodFace(index, themeColor),
            const SizedBox(height: AppSpacing.sm),
            Text(
              label,
              style: TextStyle(
                color: const Color(0xFF1E244A),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Draw custom cartoon faces for mood selector
  Widget _buildMoodFace(int index, Color themeColor) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: index == 0
            ? const Color(0xFFFFECEB)
            : index == 1
                ? const Color(0xFFE3F2FD)
                : const Color(0xFFFFFDE7),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: SizedBox(
          width: 28,
          height: 28,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Angry Face drawings
              if (index == 0) ...[
                Positioned(
                  top: 4,
                  child: Row(
                    children: [
                      Transform.rotate(
                        angle: 0.3,
                        child: Container(width: 8, height: 2.5, color: Colors.black),
                      ),
                      const SizedBox(width: 4),
                      Transform.rotate(
                        angle: -0.3,
                        child: Container(width: 8, height: 2.5, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 9,
                  child: Row(
                    children: [
                      Container(width: 4, height: 4, decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle)),
                      const SizedBox(width: 8),
                      Container(width: 4, height: 4, decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle)),
                    ],
                  ),
                ),
                Positioned(
                  top: 18,
                  child: Container(
                    width: 10,
                    height: 5,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                    ),
                  ),
                ),
              ],
              // Sad Face drawings
              if (index == 1) ...[
                Positioned(
                  top: 8,
                  child: Row(
                    children: [
                      Container(width: 4, height: 4, decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle)),
                      const SizedBox(width: 8),
                      Container(width: 4, height: 4, decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle)),
                    ],
                  ),
                ),
                Positioned(
                  top: 16,
                  child: Container(
                    width: 10,
                    height: 5,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 3,
                  top: 13,
                  child: Container(
                    width: 3.5,
                    height: 7,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ],
              // Calm Face drawings (Happy sleeping smile)
              if (index == 2) ...[
                Positioned(
                  top: 8,
                  child: Row(
                    children: [
                      const Text('^', style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold, height: 1.0)),
                      const SizedBox(width: 10),
                      const Text('^', style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold, height: 1.0)),
                    ],
                  ),
                ),
                Positioned(
                  top: 15,
                  child: Container(
                    width: 10,
                    height: 5,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // Builder for tab buttons
  Widget _buildTabButton(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: AppSpacing.sm),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFD3B6FC).withAlpha(100) : const Color(0xFFF4F6F8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? const Color(0xFF6A1B9A) : Colors.black87,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }

  // Builder for action cards
  Widget _buildActionCard({
    required String title,
    required String subtitle,
    required Color bgColor,
    required Widget iconWidget,
    required VoidCallback onTap,
  }) {
    return BaseCard(
      backgroundColor: bgColor,
      borderRadius: BorderRadius.circular(28),
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Graphic container
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(80),
              shape: BoxShape.circle,
            ),
            child: Center(child: iconWidget),
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.black45,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF1E244A),
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Builder for schedule cards (pastel style)
  Widget _buildScheduleCard({
    required String title,
    required String subtitle,
    required String time,
    required Color bgColor,
    required IconData icon,
    required Color iconColor,
  }) {
    return BaseCard(
      backgroundColor: bgColor,
      borderRadius: BorderRadius.circular(24),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(12),
                  blurRadius: 6,
                )
              ]
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF1E244A),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: TextStyle(
              color: iconColor,
              fontWeight: FontWeight.w800,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------------------
// Custom Star with Smiley Face
// ----------------------------------------------------------------------
class SmileyStarWidget extends StatelessWidget {
  const SmileyStarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44,
      height: 44,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Icon(Icons.star, color: Color(0xFFFFD54F), size: 42),
          Positioned(
            top: 15,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(width: 3.5, height: 3.5, decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle)),
                const SizedBox(width: 8),
                Container(width: 3.5, height: 3.5, decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle)),
              ],
            ),
          ),
          Positioned(
            top: 22,
            child: Container(
              width: 8,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
