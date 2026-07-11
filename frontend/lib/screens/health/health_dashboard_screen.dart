import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_spacing.dart';
import '../../widgets/layout/page_container.dart';

class HealthDashboardScreen extends StatelessWidget {
  const HealthDashboardScreen({super.key});

  Widget _buildVitalsCard({
    required String title,
    required IconData icon,
    required Widget content,
    required Color iconBgColor,
    bool showChevron = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.lg),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.black, width: 1.8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            offset: Offset(2, 4),
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
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              if (showChevron) ...[
                const Spacer(),
                const Icon(Icons.keyboard_arrow_down, color: Colors.black, size: 20),
              ],
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          content,
        ],
      ),
    );
  }

  Widget _buildSaveRow(String hintText) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black.withAlpha(25), width: 1.2),
            ),
            child: TextField(
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(color: Colors.black38, fontSize: 13),
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
    return Scaffold(
      backgroundColor: const Color(0xFFE8F1F5), // Light sky-blue neobrutalist background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Vitals',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w900,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => context.go('/home'),
        ),
      ),
      body: PageContainer(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.sm),
              
              _buildVitalsCard(
                title: 'Blood Pressure',
                icon: Icons.favorite_border_rounded,
                iconBgColor: const Color(0xFFFDCBE0), // Pink
                content: _buildSaveRow('e.g. 120/80'),
              ),
              _buildVitalsCard(
                title: 'Blood Sugar',
                icon: Icons.bloodtype_outlined,
                iconBgColor: const Color(0xFFFED782), // Yellow
                content: _buildSaveRow('e.g. 95 mg/dL'),
              ),
              _buildVitalsCard(
                title: 'Weight',
                icon: Icons.monitor_weight_outlined,
                iconBgColor: const Color(0xFFC2F3F8), // Cyan
                content: _buildSaveRow('e.g. 170 lbs'),
              ),
              _buildVitalsCard(
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
                title: 'Medicines',
                icon: Icons.medication_outlined,
                iconBgColor: const Color(0xFFC3F3C0), // Green
                content: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.check_box, color: Colors.black, size: 20),
                        const SizedBox(width: AppSpacing.xs),
                        const Text('Metformin', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
                        const SizedBox(width: AppSpacing.md),
                        const Icon(Icons.check_box_outline_blank, color: Colors.black54, size: 20),
                        const SizedBox(width: AppSpacing.xs),
                        const Text('Lisinopril', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      children: [
                        const Icon(Icons.check_box_outline_blank, color: Colors.black54, size: 20),
                        const SizedBox(width: AppSpacing.xs),
                        const Text('Lisinopril', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
                        const Spacer(),
                        // Neobrutalist Save Button for medicines card
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFFC3F3C0), // Vibrant Green neobrutalist
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
