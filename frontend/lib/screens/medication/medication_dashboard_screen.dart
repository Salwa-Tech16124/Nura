import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/layout/page_container.dart';
import '../../core/constants/app_spacing.dart';
import '../../models/medicine_model.dart';
import '../../providers/medicine_provider.dart';
import '../../services/api_client.dart';

class MedicationDashboardScreen extends ConsumerStatefulWidget {
  const MedicationDashboardScreen({super.key});

  @override
  ConsumerState<MedicationDashboardScreen> createState() =>
      _MedicationDashboardScreenState();
}

class _MedicationDashboardScreenState
    extends ConsumerState<MedicationDashboardScreen> {
  // ── Add Medicine Dialog ──────────────────────────────────────────────────
  void _showAddMedicineDialog() {
    final nameCtrl = TextEditingController();
    final dosageCtrl = TextEditingController();
    final timeCtrl = TextEditingController();
    final freqCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.black, width: 2),
        ),
        title: const Text('Add Medicine',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _addField(nameCtrl, 'Medicine Name *'),
            const SizedBox(height: 10),
            _addField(dosageCtrl, 'Dosage (e.g. 500mg)'),
            const SizedBox(height: 10),
            _addField(timeCtrl, 'Time (e.g. 9:00 AM)'),
            const SizedBox(height: 10),
            _addField(freqCtrl, 'Frequency (e.g. Daily)'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFC3F3C0),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: Colors.black, width: 1.5),
              ),
            ),
            onPressed: () async {
              final name = nameCtrl.text.trim();
              if (name.isEmpty) return;
              Navigator.of(ctx).pop();
              try {
                await ref.read(medicinesProvider.notifier).addMedicine(
                      MedicineModel(
                        medicineName: name,
                        dosage: dosageCtrl.text.trim().isEmpty
                            ? null
                            : dosageCtrl.text.trim(),
                        time: timeCtrl.text.trim().isEmpty
                            ? null
                            : timeCtrl.text.trim(),
                        frequency: freqCtrl.text.trim().isEmpty
                            ? null
                            : freqCtrl.text.trim(),
                      ),
                    );
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$name added! ✓'),
                      backgroundColor: Colors.green.shade600,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  );
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(ApiClient.extractError(e))),
                  );
                }
              }
            },
            child: const Text('Add', style: TextStyle(fontWeight: FontWeight.w900)),
          ),
        ],
      ),
    );
  }

  Widget _addField(TextEditingController ctrl, String hint) {
    return TextField(
      controller: ctrl,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 13),
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.black),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
    );
  }

  // ── Section Header ────────────────────────────────────────────────────────
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

  // ── Status Badge ──────────────────────────────────────────────────────────
  Widget _buildStatusBadge(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFFED782),
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

  // ── Medicine Card ──────────────────────────────────────────────────────────
  Widget _buildMedicineCard({
    required String name,
    required String dosage,
    required String time,
    required Widget statusBadge,
    required Color iconBgColor,
    required IconData icon,
    VoidCallback? onDelete,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black, width: 1.8),
        boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(2, 4))],
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
                child: Center(child: Icon(icon, color: Colors.black, size: 18)),
              ),
              const SizedBox(width: AppSpacing.md),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          fontSize: 14)),
                  Text(dosage,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                          fontSize: 12)),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(time,
                  style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                      fontSize: 13)),
              const SizedBox(height: AppSpacing.xs),
              statusBadge,
              if (onDelete != null)
                GestureDetector(
                  onTap: onDelete,
                  child: const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Icon(Icons.delete_outline,
                        color: Colors.redAccent, size: 18),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Build ─────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final medsAsync = ref.watch(medicinesProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFE8F1F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Medication Reminder',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w900, fontSize: 20),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => context.go('/home'),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              margin: const EdgeInsets.only(top: 8, bottom: 8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 1.8),
              ),
              child: const CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.black, size: 18),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddMedicineDialog,
        backgroundColor: const Color(0xFFC3F3C0),
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Colors.black, width: 1.8),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Add Medicine', style: TextStyle(fontWeight: FontWeight.w900)),
      ),
      body: PageContainer(
        child: ScrollablePageLayout(
          children: [
            const SizedBox(height: AppSpacing.sm),
            const Text(
              'Stay on track with today\'s medications.',
              style: TextStyle(
                  color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: AppSpacing.lg),

            // ── Live Medicines from Backend ──────────────────────────────
            medsAsync.when(
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(AppSpacing.xl),
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (e, _) => Center(
                child: Text(
                  'Could not load medicines: ${ApiClient.extractError(e)}',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              data: (medicines) {
                if (medicines.isEmpty) {
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.xl),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.black, width: 1.8),
                        boxShadow: const [
                          BoxShadow(color: Colors.black, offset: Offset(2, 4))
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.medication_liquid,
                              size: 60, color: Colors.black87),
                          SizedBox(height: AppSpacing.sm),
                          Text(
                            'No medicines added yet.\nTap + to add one.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader('Your Medications (${medicines.length})'),
                    ...medicines.map((m) => Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.md),
                          child: _buildMedicineCard(
                            name: m.medicineName,
                            dosage: m.dosage ?? '1 dose',
                            time: m.time ?? '--',
                            icon: Icons.medication,
                            iconBgColor: const Color(0xFFC2F3F8),
                            statusBadge: _buildStatusBadge('Scheduled'),
                            onDelete: m.id != null
                                ? () async {
                                    await ref
                                        .read(medicinesProvider.notifier)
                                        .deleteMedicine(m.id!);
                                  }
                                : null,
                          ),
                        )),
                  ],
                );
              },
            ),
            const SizedBox(height: AppSpacing.lg),

            // ── Reminder Card ────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: const Color(0xFFFED782),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.black, width: 1.8),
                boxShadow: const [
                  BoxShadow(color: Colors.black, offset: Offset(2, 4))
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
                      child: Icon(Icons.info_outline_rounded,
                          color: Colors.black, size: 22),
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
                              fontSize: 16),
                        ),
                        SizedBox(height: AppSpacing.xs),
                        Text(
                          'Tap the + button to add medicines and track your schedule.',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            // ── Back to Home ─────────────────────────────────────────────
            Container(
              width: double.infinity,
              height: 52,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                color: const Color(0xFFE5D5FF),
                border: Border.all(color: Colors.black, width: 1.8),
                boxShadow: const [
                  BoxShadow(color: Colors.black, offset: Offset(2, 4))
                ],
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28)),
                ),
                onPressed: () => context.go('/home'),
                child: const Text(
                  'Back to Home Dashboard',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5),
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
