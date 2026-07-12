import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_spacing.dart';
import '../../widgets/layout/page_container.dart';

class ReportDashboardScreen extends StatelessWidget {
  const ReportDashboardScreen({super.key});

  // Local helper for section headers
  Widget _buildSectionHeader(BuildContext context, String title) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
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

  // Neobrutalist StatCard builder
  Widget _buildNeobrutalistStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color iconBgColor,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF121625) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isDark ? Colors.white24 : Colors.black, width: 1.8),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.white10 : Colors.black,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 1.5),
                ),
                child: Center(
                  child: Icon(icon, color: Colors.black, size: 16),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  title, 
                  style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white70 : Colors.black54, fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            value, 
            style: TextStyle(fontWeight: FontWeight.w900, color: isDark ? Colors.white : Colors.black, fontSize: 18),
          ),
        ],
      ),
    );
  }

  // Neobrutalist ReportCategoryCard builder
  Widget _buildNeobrutalistReportCategoryCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color iconBgColor,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF121625) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isDark ? Colors.white24 : Colors.black, width: 1.8),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.white10 : Colors.black,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 1.8),
            ),
            child: Center(
              child: Icon(icon, color: Colors.black, size: 22),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title, 
                  style: TextStyle(fontWeight: FontWeight.w900, color: isDark ? Colors.white : Colors.black, fontSize: 14),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  description, 
                  style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white70 : Colors.black54, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          // Outlined Neobrutalist "View" Button
          Container(
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFC2F3F8), // Cyan neobrutalist view button
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.black, width: 1.8),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(1, 2),
                ),
              ],
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              onPressed: onTap,
              child: const Text(
                'View', 
                style: TextStyle(fontWeight: FontWeight.w900, color: Colors.black, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
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
          'Health Reports',
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
        child: ScrollablePageLayout(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Your personalized health insights and reports.', 
              style: TextStyle(
                color: isDark ? Colors.white70 : Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Quick Statistics
            _buildSectionHeader(context, 'Quick Statistics'),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: AppSpacing.md,
              crossAxisSpacing: AppSpacing.md,
              childAspectRatio: 1.45,
              children: [
                _buildNeobrutalistStatCard(
                  context,
                  title: 'Health Score', 
                  value: '86 / 100', 
                  icon: Icons.health_and_safety,
                  iconBgColor: const Color(0xFFFED782), // Yellow
                ),
                _buildNeobrutalistStatCard(
                  context,
                  title: 'Medicine Adherence', 
                  value: '92%', 
                  icon: Icons.medication,
                  iconBgColor: const Color(0xFFFDCBE0), // Pink
                ),
                _buildNeobrutalistStatCard(
                  context,
                  title: 'Average Steps', 
                  value: '7,450', 
                  icon: Icons.directions_walk,
                  iconBgColor: const Color(0xFFE5D5FF), // Lilac
                ),
                _buildNeobrutalistStatCard(
                  context,
                  title: 'Heart Rate', 
                  value: '76 BPM', 
                  icon: Icons.favorite,
                  iconBgColor: const Color(0xFFC2F3F8), // Cyan
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),

            // AI Insight Card (Neobrutalist style info strip)
            InkWell(
              onTap: () => context.push('/ai-summary'),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E2A3A) : const Color(0xFFC2F3F8), // Dynamic background
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: isDark ? Colors.white24 : Colors.black, width: 1.8),
                  boxShadow: [
                    BoxShadow(
                      color: isDark ? Colors.white10 : Colors.black,
                      offset: const Offset(2, 4),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 1.8),
                      ),
                      child: const Center(
                        child: Icon(Icons.auto_awesome, color: Colors.black, size: 18),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'AI Insight', 
                            style: TextStyle(fontWeight: FontWeight.w900, color: isDark ? Colors.white : Colors.black, fontSize: 15),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            '"Your overall health has improved by 12% compared to last month."',
                            style: TextStyle(fontStyle: FontStyle.italic, color: isDark ? Colors.white70 : Colors.black87, fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            // Report Categories
            _buildSectionHeader(context, 'Report Categories'),
            _buildNeobrutalistReportCategoryCard(
              context,
              title: 'Weekly Health Report',
              description: 'Summary of your health metrics for the week.',
              icon: Icons.calendar_view_week,
              iconBgColor: const Color(0xFFC3F3C0), // Green
              onTap: () => context.push('/weekly-report'),
            ),
            _buildNeobrutalistReportCategoryCard(
              context,
              title: 'Monthly Health Report',
              description: 'Detailed analysis of your monthly wellness.',
              icon: Icons.calendar_month,
              iconBgColor: const Color(0xFFFDCBE0), // Pink
              onTap: () => context.push('/monthly-report'),
            ),
            _buildNeobrutalistReportCategoryCard(
              context,
              title: 'Doctor Summary',
              description: 'Formatted report ready for your physician.',
              icon: Icons.medical_services,
              iconBgColor: const Color(0xFFFED782), // Yellow
              onTap: () => context.push('/doctor-summary'),
            ),

            _buildNeobrutalistReportCategoryCard(
              context,
              title: 'AI Health Summary',
              description: 'AI-generated personalized health insights.',
              icon: Icons.auto_awesome,
              iconBgColor: const Color(0xFFC2F3F8), // Cyan
              onTap: () => context.push('/ai-summary'),
            ),
            _buildNeobrutalistReportCategoryCard(
              context,
              title: 'Medication Report',
              description: 'Adherence history and missed doses.',
              icon: Icons.medication_liquid,
              iconBgColor: const Color(0xFFC3F3C0), // Green
              onTap: () => context.push('/meds-history'),
            ),
            const SizedBox(height: AppSpacing.xl),

            // Bottom Actions
            // 1. Generate New Report Button (Cyan neobrutalist)
            Container(
              width: double.infinity,
              height: 52,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                color: const Color(0xFFC2F3F8), // Cyan
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
                onPressed: () {},
                child: const Text(
                  'Generate New Report',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            // 2. Export Reports Button (Yellow neobrutalist)
            Container(
              width: double.infinity,
              height: 52,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                color: const Color(0xFFFED782), // Yellow
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
                onPressed: () {},
                child: const Text(
                  'Export Reports',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
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
