import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_spacing.dart';
import '../../widgets/layout/page_container.dart';
import '../../models/health_log_model.dart';
import '../../providers/health_provider.dart';
import '../../services/api_client.dart';

class HealthDashboardScreen extends ConsumerStatefulWidget {
  const HealthDashboardScreen({super.key});

  @override
  ConsumerState<HealthDashboardScreen> createState() =>
      _HealthDashboardScreenState();
}

class _HealthDashboardScreenState extends ConsumerState<HealthDashboardScreen> {
  final _bpController = TextEditingController();
  final _sugarController = TextEditingController();
  final _weightController = TextEditingController();
  bool _isSaving = false;

  @override
  void dispose() {
    _bpController.dispose();
    _sugarController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  Future<void> _saveVitals() async {
    final bp = _bpController.text.trim();
    final sugar = double.tryParse(_sugarController.text.trim());
    final weight = double.tryParse(_weightController.text.trim());

    if (bp.isEmpty && sugar == null && weight == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter at least one vital.')),
      );
      return;
    }

    setState(() => _isSaving = true);
    try {
      await ref.read(healthHistoryProvider.notifier).addLog(
            HealthLogModel(
              bloodPressure: bp.isEmpty ? null : bp,
              sugarLevel: sugar,
              weight: weight,
            ),
          );
      if (mounted) {
        _bpController.clear();
        _sugarController.clear();
        _weightController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Vitals saved successfully! ✓'),
            backgroundColor: Colors.green.shade600,
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(ApiClient.extractError(e))),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

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
          BoxShadow(color: Colors.black, offset: Offset(2, 4)),
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
                child: Center(child: Icon(icon, color: Colors.black, size: 18)),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                      fontSize: 16)),
              if (showChevron) ...[
                const Spacer(),
                const Icon(Icons.keyboard_arrow_down,
                    color: Colors.black, size: 20),
              ],
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          content,
        ],
      ),
    );
  }

  Widget _buildInputRow(TextEditingController controller, String hint) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: Colors.black.withAlpha(25), width: 1.2),
            ),
            child: TextField(
              controller: controller,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle:
                    const TextStyle(color: Colors.black38, fontSize: 13),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Container(
          height: 44,
          decoration: BoxDecoration(
            color: const Color(0xFFC3F3C0),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black, width: 1.8),
            boxShadow: const [
              BoxShadow(color: Colors.black, offset: Offset(1, 2)),
            ],
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              padding: const EdgeInsets.symmetric(horizontal: 20),
            ),
            onPressed: _isSaving ? null : _saveVitals,
            child: _isSaving
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child:
                        CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Save',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                        fontSize: 14)),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Watch health history to show recent log
    final historyAsync = ref.watch(healthHistoryProvider);
    final latestLog = historyAsync.valueOrNull?.isNotEmpty == true
        ? historyAsync.valueOrNull!.first
        : null;

    return Scaffold(
      backgroundColor: const Color(0xFFE8F1F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text('Vitals',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w900,
                fontSize: 20)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              color: Colors.black, size: 20),
          onPressed: () => context.go('/home'),
        ),
      ),
      body: PageContainer(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.sm),

              // Show latest logged vitals banner if available
              if (latestLog != null)
                Container(
                  margin: const EdgeInsets.only(bottom: AppSpacing.md),
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF9C4),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.black, width: 1.5),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.history, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Last logged: '
                          '${latestLog.bloodPressure != null ? "BP ${latestLog.bloodPressure}" : ""}'
                          '${latestLog.sugarLevel != null ? "  Sugar ${latestLog.sugarLevel} mg/dL" : ""}'
                          '${latestLog.weight != null ? "  Weight ${latestLog.weight} kg" : ""}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),

              _buildVitalsCard(
                title: 'Blood Pressure',
                icon: Icons.favorite_border_rounded,
                iconBgColor: const Color(0xFFFDCBE0),
                content: _buildInputRow(_bpController, 'e.g. 120/80'),
              ),
              _buildVitalsCard(
                title: 'Blood Sugar',
                icon: Icons.bloodtype_outlined,
                iconBgColor: const Color(0xFFFED782),
                content: _buildInputRow(_sugarController, 'e.g. 95 mg/dL'),
              ),
              _buildVitalsCard(
                title: 'Weight',
                icon: Icons.monitor_weight_outlined,
                iconBgColor: const Color(0xFFC2F3F8),
                content: _buildInputRow(_weightController, 'e.g. 70 kg'),
              ),
              _buildVitalsCard(
                title: 'Symptoms',
                icon: Icons.emoji_emotions_outlined,
                iconBgColor: const Color(0xFFE5D5FF),
                showChevron: true,
                content: Row(
                  children: [
                    _symptomBadge('Headaches'),
                    const SizedBox(width: AppSpacing.sm),
                    _symptomBadge('Fatigue'),
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

  Widget _symptomBadge(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFC3F3C0),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black, width: 1.5),
      ),
      child: Text(label,
          style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w900,
              fontSize: 12)),
    );
  }
}
