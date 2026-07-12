import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_spacing.dart';
import '../../widgets/layout/page_container.dart';

class HealthDashboardScreen extends StatelessWidget {
  const HealthDashboardScreen({super.key});

  Widget _buildVitalsCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Widget content,
    required Color iconBgColor,
    bool showChevron = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 1.8),
                ),
                child: Center(
                  child: Icon(icon, color: Colors.black, size: 18),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                title, 
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: isDark ? Colors.white : Colors.black,
                  fontSize: 16,
                ),
              ),
              if (showChevron) ...[
                const Spacer(),
                Icon(Icons.keyboard_arrow_down, color: isDark ? Colors.white : Colors.black, size: 20),
              ],
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          content,
        ],
      ),
    );
  }

  Widget _buildSaveRow(BuildContext context, String hintText) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: isDark ? Colors.white.withAlpha(10) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: isDark ? Colors.white24 : Colors.black.withAlpha(25), width: 1.2),
            ),
            child: TextField(
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: isDark ? Colors.white38 : Colors.black38, fontSize: 13),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        // Neobrutalist Save Button
        Container(
          height: 44,
          decoration: BoxDecoration(
            color: const Color(0xFFC3F3C0), // Vibrant Green neobrutalist
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: isDark ? Colors.white24 : Colors.black, width: 1.8),
            boxShadow: [
              BoxShadow(
                color: isDark ? Colors.white10 : Colors.black,
                offset: const Offset(1, 2),
              ),
            ],
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              padding: const EdgeInsets.symmetric(horizontal: 20),
            ),
            onPressed: () {},
            child: const Text(
              'Save', 
              style: TextStyle(fontWeight: FontWeight.w900, color: Colors.black, fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0A0C16) : const Color(0xFFE8F1F5), // Dynamic neobrutalist background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Vitals',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.w900,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: isDark ? Colors.white : Colors.black, size: 20),
          onPressed: () => context.go('/home'),
        ),
      ),
      body: PageContainer(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.sm),

              // Top Dashboard Illustration Banner
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
                        'assets/images/branding/health_illustration.jpg',
                        height: 145,
                        width: double.infinity,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'Your Personal Health Tracker',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Log your vitals, monitor medicines, and view reports.',
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
              
              _buildVitalsCard(
                context,
                title: 'Blood Pressure',
                icon: Icons.favorite_border_rounded,
                iconBgColor: const Color(0xFFFDCBE0), // Pink
                content: _buildSaveRow(context, 'e.g. 120/80'),
              ),
              _buildVitalsCard(
                context,
                title: 'Blood Sugar',
                icon: Icons.bloodtype_outlined,
                iconBgColor: const Color(0xFFFED782), // Yellow
                content: _buildSaveRow(context, 'e.g. 95 mg/dL'),
              ),
              _buildVitalsCard(
                context,
                title: 'Weight',
                icon: Icons.monitor_weight_outlined,
                iconBgColor: const Color(0xFFC2F3F8), // Cyan
                content: _buildSaveRow(context, 'e.g. 170 lbs'),
              ),
              _buildVitalsCard(
                context,
                title: 'Symptoms',
                icon: Icons.emoji_emotions_outlined,
                iconBgColor: const Color(0xFFE5D5FF), // Lilac
                showChevron: true,
                content: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFC3F3C0), // Green
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black, width: 1.5),
                      ),
                      child: const Text(
                        'Headaches', 
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 12),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFC3F3C0), // Green
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black, width: 1.5),
                      ),
                      child: const Text(
                        'Fatigue', 
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              _buildVitalsCard(
                context,
                title: 'Medicines',
                icon: Icons.medication_outlined,
                iconBgColor: const Color(0xFFC3F3C0), // Green
                content: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.check_box, color: isDark ? Colors.white : Colors.black, size: 20),
                        const SizedBox(width: AppSpacing.xs),
                        Text('Metformin', style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white70 : Colors.black87)),
                        const SizedBox(width: AppSpacing.md),
                        Icon(Icons.check_box_outline_blank, color: isDark ? Colors.white38 : Colors.black54, size: 20),
                        const SizedBox(width: AppSpacing.xs),
                        Text('Lisinopril', style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white70 : Colors.black87)),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      children: [
                        Icon(Icons.check_box_outline_blank, color: isDark ? Colors.white38 : Colors.black54, size: 20),
                        const SizedBox(width: AppSpacing.xs),
                        Text('Lisinopril', style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white70 : Colors.black87)),
                        const Spacer(),
                        // Neobrutalist Save Button for medicines card
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFFC3F3C0), // Vibrant Green neobrutalist
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: isDark ? Colors.white24 : Colors.black, width: 1.8),
                            boxShadow: [
                              BoxShadow(
                                color: isDark ? Colors.white10 : Colors.black,
                                offset: const Offset(1, 2),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                              padding: const EdgeInsets.symmetric(horizontal: 18),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Save', 
                              style: TextStyle(fontWeight: FontWeight.w900, color: Colors.black, fontSize: 13),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),
            ],
          ),
        ),
      ),
    );
  }
}
