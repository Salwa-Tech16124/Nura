import 'package:flutter/material.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../widgets/layout/page_container.dart';
import '../../widgets/navigation.dart';

class HealthTrendsScreen extends StatelessWidget {
  const HealthTrendsScreen({super.key});

  Widget _buildDummyChart(String title, Color color, List<String> yLabels) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.border.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: AppSpacing.lg),
          // Dummy chart representation
          SizedBox(
            height: 180,
            child: Row(
              children: [
                // Y-axis
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: yLabels.map((l) => Text(l, style: AppTypography.bodySmall.copyWith(fontSize: 10))).toList(),
                ),
                const SizedBox(width: AppSpacing.sm),
                // Graph Area
                Expanded(
                  child: Stack(
                    children: [
                      // Grid lines
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(yLabels.length, (index) => Container(height: 1, color: AppColors.border.withOpacity(0.5))),
                      ),
                      // Fake line chart placeholder
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: Icon(Icons.ssid_chart, size: 100, color: color),
                        ),
                      ),
                      // Tooltip dummy
                      Positioned(
                        top: 20,
                        right: 40,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            border: Border.all(color: AppColors.border),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text('Weekly\naverages', style: AppTypography.bodySmall.copyWith(fontSize: 8), textAlign: TextAlign.center),
                        ),
                      ),
                      // X-axis labels
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('Mon', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                            Text('Wed', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                            Text('Wed', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                            Text('Wed', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                            Text('Wed', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: 'Trends',
        showBackButton: true,
      ),
      body: PageContainer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.sm),
              _buildDummyChart(
                'BP Trend (Last 30 Days)', 
                AppColors.primary,
                ['140', '130', '120', '110', '100', '90', '80']
              ),
              _buildDummyChart(
                'Blood Sugar (Last 30 Days)', 
                AppColors.secondary,
                ['100', '80', '60', '40', '20', '0']
              ),
            ],
          ),
        ),
      ),
    );
  }
}
