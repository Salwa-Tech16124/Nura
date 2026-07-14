import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/layout/page_container.dart';
import '../../core/constants/app_spacing.dart';

class MedicationDashboardScreen extends StatefulWidget {
  const MedicationDashboardScreen({super.key});

  @override
  State<MedicationDashboardScreen> createState() => _MedicationDashboardScreenState();
}

class _MedicationDashboardScreenState extends State<MedicationDashboardScreen> {
  final bool _hasMedicines = true; // Toggle for empty state testing
  
  final List<Map<String, dynamic>> _upcomingMedicines = [
    {
      'name': 'Lisinopril 10mg',
      'time': '9:00 AM',
      'status': 'Pending',
    },
    {
      'name': 'Vitamin D',
      'time': '2:00 PM',
      'status': 'Upcoming',
    },
    {
      'name': 'Metformin 500mg',
      'time': '8:00 PM',
      'status': 'Upcoming',
    }
  ];

  // Local helper for section headers
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

  // Soft yellow neobrutalist status badge
  Widget _buildNeobrutalistStatusBadge(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFFED782), // Soft yellow neobrutalist
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.access_time, color: Colors.black87, size: 12),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w900,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  // Neobrutalist medicine card builder
  Widget _buildNeobrutalistMedicineCard(
    BuildContext context, {
    required String name,
    required String dosage,
    required String time,
    required Widget statusBadge,
    required Color iconBgColor,
    required IconData icon,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 1.8),
                ),
                child: Center(
                  child: Icon(icon, color: Colors.black, size: 18),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name, 
                    style: TextStyle(fontWeight: FontWeight.w900, color: isDark ? Colors.white : Colors.black, fontSize: 14),
                  ),
                  Text(
                    dosage, 
                    style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white70 : Colors.black54, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                time, 
                style: TextStyle(fontWeight: FontWeight.w900, color: isDark ? Colors.white : Colors.black, fontSize: 13),
              ),
              const SizedBox(height: AppSpacing.xs),
              statusBadge,
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineCard(BuildContext context, Map<String, dynamic> med, bool isLast) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    Widget badge = _buildNeobrutalistStatusBadge(med['status']);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 32,
            child: Column(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  margin: const EdgeInsets.only(top: 28),
                  decoration: BoxDecoration(
                    color: med['status'] == 'Taken' ? const Color(0xFFC3F3C0) : const Color(0xFFFDCBE0),
                    shape: BoxShape.circle,
                    border: Border.all(color: isDark ? Colors.white70 : Colors.black, width: 1.8),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: isDark ? Colors.white24 : Colors.black,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: _buildNeobrutalistMedicineCard(
                context,
                name: med['name'],
                dosage: '1 Pill',
                time: med['time'],
                icon: Icons.medication,
                iconBgColor: med['status'] == 'Taken' ? const Color(0xFFC3F3C0) : const Color(0xFFC2F3F8),
                statusBadge: badge,
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
          'Medication Reminder',
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              margin: const EdgeInsets.only(top: 8, bottom: 8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: isDark ? Colors.white24 : Colors.black, width: 1.8),
              ),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: isDark ? const Color(0xFF121625) : Colors.white,
                child: Icon(Icons.person, color: isDark ? Colors.white : Colors.black, size: 18),
              ),
            ),
          )
        ],
      ),
      body: PageContainer(
        child: ScrollablePageLayout(
          children: [
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Stay on track with today\'s medications.',
              style: TextStyle(
                color: isDark ? Colors.white70 : Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Top Meds Banner Illustration Card
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
                      'assets/images/branding/meds_illustration.jpg',
                      height: 145,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Daily Medication Tracker',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'Stay healthy by tracking your pill schedule and prescriptions.',
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

            if (!_hasMedicines) ...[
              const SizedBox(height: AppSpacing.xxl),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF121625) : Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: isDark ? Colors.white24 : Colors.black, width: 1.8),
                    boxShadow: [
                      BoxShadow(
                        color: isDark ? Colors.white10 : Colors.black,
                        offset: const Offset(2, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.medication_liquid, size: 60, color: isDark ? Colors.white : Colors.black87),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        'No medicines scheduled for today.',
                        style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ] else ...[
              // Adherence Progress
              _buildSectionHeader('Today\'s Adherence', isDark: isDark),
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF121625) : Colors.white,
                  borderRadius: BorderRadius.circular(24),
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
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '2 of 5 medicines taken today', 
                          style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white70 : Colors.black87, fontSize: 13),
                        ),
                        Text(
                          '40% Completed', 
                          style: TextStyle(fontWeight: FontWeight.w900, color: isDark ? Colors.white : Colors.black, fontSize: 13),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    // Outlined neobrutalist progress bar
                    Container(
                      height: 12,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: isDark ? Colors.white.withAlpha(10) : Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: isDark ? Colors.white24 : Colors.black, width: 1.5),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: 0.4,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFC2F3F8), // Cyan progress fill
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Today's Medication Card
              _buildSectionHeader('Today\'s Medication', isDark: isDark),
              _buildNeobrutalistMedicineCard(
                context,
                name: 'Lisinopril 10mg',
                dosage: '1 Pill',
                time: '9:00 AM',
                icon: Icons.medication,
                iconBgColor: const Color(0xFFC2F3F8), // Cyan
                statusBadge: _buildNeobrutalistStatusBadge('Pending'),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Upcoming Medicines Timeline
              _buildSectionHeader('Upcoming Medicines', isDark: isDark),
              if (_upcomingMedicines.isEmpty)
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF121625) : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: isDark ? Colors.white24 : Colors.black, width: 1.8),
                  ),
                  child: Text('No upcoming medicines.', style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
                )
              else
                ...List.generate(_upcomingMedicines.length, (index) {
                  return _buildTimelineCard(context, _upcomingMedicines[index], index == _upcomingMedicines.length - 1);
                }),
              const SizedBox(height: AppSpacing.lg),

              // Quick Actions
              // 1. Log Medicine Taken Button (Cyan solid neobrutalist)
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
                  onPressed: () => context.push('/meds-notification'),
                  child: const Text(
                    'Log Medicine Taken',
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
              // 2. View Medication History Button (Pink solid neobrutalist)
              Container(
                width: double.infinity,
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  color: const Color(0xFFFDCBE0), // Pink
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
                  onPressed: () => context.push('/meds-history'),
                  child: const Text(
                    'View Medication History',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              // Reminder Status Card (Yellow background neobrutalist)
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: const Color(0xFFFED782), // Soft Yellow
                  borderRadius: BorderRadius.circular(24),
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
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 1.8),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.info_outline_rounded,
                          color: Colors.black,
                          size: 22,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Reminder Status',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: AppSpacing.xs),
                          Text(
                            'Your next medication is scheduled for 2:00 PM.',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
            ],

            // Back to Home Button (Lilac solid neobrutalist)
            Container(
              width: double.infinity,
              height: 52,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                color: const Color(0xFFE5D5FF), // Lilac
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
                onPressed: () {
                  context.go('/home');
                },
                child: const Text(
                  'Back to Home Dashboard',
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
