import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_spacing.dart';
import '../../widgets/layout/page_container.dart';
import '../../widgets/voice_wave_animation.dart';
import '../../core/services/audio_service.dart';

class HealthWellnessScreen extends StatefulWidget {
  const HealthWellnessScreen({super.key});

  @override
  State<HealthWellnessScreen> createState() => _HealthWellnessScreenState();
}

class _HealthWellnessScreenState extends State<HealthWellnessScreen> {
  // 1. Health Tracking State
  int _heartRate = 72;
  double _systolic = 120;
  double _diastolic = 80;
  int _bloodSugar = 95;
  double _temperature = 98.6;
  int _waterGlasses = 6;
  final int _waterGoal = 8;
  double _sleepHours = 7.5;

  // 2. Recommendations State (Checklist)
  final List<Map<String, dynamic>> _recommendations = [
    {'text': 'Log daily symptoms', 'completed': false, 'desc': 'Important for AI care insights.'},
    {'text': 'Drink more water', 'completed': false, 'desc': 'Need 2 more glasses.'},
    {'text': 'Reduce sugar intake', 'completed': false, 'desc': 'Avoid sugary snacks after lunch.'},
    {'text': 'Sleep before 11 PM', 'completed': false, 'desc': 'Essential for sleep cycle.'},
    {'text': 'Check blood pressure tomorrow', 'completed': false, 'desc': 'Keep tracking daily trends.'},
  ];

  // 3. Simulated Medicine Guide Voice Playback
  bool _isPlayingVoiceGuide = false;

  int _selectedTab = 0; // 0 = Timeline, 1 = Health Trends

  final List<Map<String, dynamic>> _timelineEvents = [
    {
      'time': 'Just Now',
      'title': 'AI Insight Generated',
      'subtitle': 'AI analyzed your blood sugar trends and recommends reducing evening carbs.',
      'icon': Icons.auto_awesome,
      'color': const Color(0xFF81C784),
    },
    {
      'time': '10:32 AM',
      'title': 'Emergency SOS Triggered',
      'subtitle': 'SOS Alert sent to Mom, Sarah, and Mike. Status: Alert Sent.',
      'icon': Icons.warning_rounded,
      'color': const Color(0xFFFF5252),
    },
    {
      'time': '09:15 AM',
      'title': 'Medicine Taken',
      'subtitle': 'Metformin 500 mg taken with breakfast.',
      'icon': Icons.check_circle_rounded,
      'color': const Color(0xFF69F0AE),
    },
    {
      'time': '08:30 AM',
      'title': 'Blood Sugar Updated',
      'subtitle': 'Blood sugar logged: 95 mg/dL (Normal).',
      'icon': Icons.water_drop,
      'color': const Color(0xFFFFAB40),
    },
    {
      'time': '08:15 AM',
      'title': 'Blood Pressure Recorded',
      'subtitle': 'BP logged: 120/80 mmHg (Optimal).',
      'icon': Icons.monitor_heart,
      'color': const Color(0xFF40C4FF),
    },
    {
      'time': 'Yesterday, 04:00 PM',
      'title': 'Doctor Summary Created',
      'subtitle': 'Weekly clinical summary formatted and ready to share with Dr. Anderson.',
      'icon': Icons.description_rounded,
      'color': const Color(0xFFFED782),
    },
    {
      'time': 'Yesterday, 02:30 PM',
      'title': 'Symptoms Logged',
      'subtitle': 'Reported mild headache. AI copilot suggested hydration check.',
      'icon': Icons.edit_note_rounded,
      'color': const Color(0xFFFFD740),
    },
    {
      'time': '2 Days Ago',
      'title': 'Medicine Started',
      'subtitle': 'Started daily dosage of Lisinopril 10 mg as prescribed.',
      'icon': Icons.play_arrow_rounded,
      'color': const Color(0xFFD3B6FC),
    },
    {
      'time': '3 Days Ago',
      'title': 'OCR Prescription Processed',
      'subtitle': 'Prescription for Lisinopril 10 mg successfully scanned.',
      'icon': Icons.qr_code_scanner,
      'color': const Color(0xFFFBB584),
    },
    {
      'time': '5 Days Ago',
      'title': 'Report Uploaded',
      'subtitle': 'Blood Test Report (Oct 2026) added to Medical Records.',
      'icon': Icons.file_upload_rounded,
      'color': const Color(0xFF94B6FF),
    },
  ];

  @override
  void dispose() {
    AudioService().stopVoicePlaySound();
    super.dispose();
  }

  // 4. Medicine Scanner Simulation States
  bool _isScanning = false;
  bool _showOcrResult = false;

  // 5. Medicine Information State
  String _selectedMedicine = 'Lisinopril';
  final Map<String, Map<String, String>> _medicineDb = {
    'Lisinopril': {
      'name': 'Lisinopril',
      'purpose': 'ACE Inhibitor',
      'uses': 'Used to treat high blood pressure (hypertension), congestive heart failure, and to improve survival after a heart attack.',
      'benefits': 'Lowers blood pressure, reducing the risk of fatal and nonfatal cardiovascular events, primarily strokes and heart attacks.',
      'sideEffects': 'Dry cough, dizziness, lightheadedness, headache, excessive tiredness.',
      'warnings': 'Do not use if pregnant. Can cause serious harm or death to unborn fetus. Swelling of face, lips, tongue, or throat must be reported immediately.',
      'foodRestrictions': 'Avoid high-potassium foods and salt substitutes containing potassium without consulting a doctor.',
      'storage': 'Store at room temperature (20-25°C) away from moisture, heat, and light. Keep container tightly closed.',
      'dosage': 'Adults: Typically 10mg once daily. Elderly: May start at 5mg daily. Adjustments based on kidney function.',
    },
    'Metformin': {
      'name': 'Metformin',
      'purpose': 'Biguanide Antidiabetic',
      'uses': 'Prescribed with diet and exercise to improve blood sugar control in adults with type 2 diabetes mellitus.',
      'benefits': 'Improves insulin sensitivity, lowers glucose production in liver, and decreases absorption of glucose in intestines.',
      'sideEffects': 'Nausea, vomiting, diarrhea, stomach upset, metallic taste in mouth.',
      'warnings': 'Risk of lactic acidosis, a rare but serious metabolic complication. Avoid excessive alcohol. Monitor kidney function regularly.',
      'foodRestrictions': 'Take with meals to reduce gastrointestinal side effects. Limit alcohol consumption.',
      'storage': 'Store at room temperature (15-30°C) in a dry place. Keep out of reach of children.',
      'dosage': 'Adults: Initial dose 500mg or 850mg twice daily with meals. Maximum daily dose is 2550mg.',
    },
    'Atorvastatin': {
      'name': 'Atorvastatin (Lipitor)',
      'purpose': 'HMG-CoA Reductase Inhibitor (Statin)',
      'uses': 'Used to lower cholesterol and triglycerides in the blood, decreasing risks of stroke, heart attack, and other heart complications.',
      'benefits': 'Significantly lowers LDL ("bad") cholesterol and triglycerides while raising HDL ("good") cholesterol levels.',
      'sideEffects': 'Muscle aches/pain, headache, minor digestive complaints, joint pain.',
      'warnings': 'Avoid grapefruit and grapefruit juice, as they can increase statin levels in blood. Report unexplained muscle pain immediately.',
      'foodRestrictions': 'Do not consume large quantities of grapefruit juice (more than 1.2 liters daily). Limit alcohol intake.',
      'storage': 'Store at room temperature (20-25°C) in a tight container. Keep away from moisture.',
      'dosage': 'Adults: 10mg to 80mg once daily, at any time of day, with or without food. Adjust based on lipid level targets.',
    },
  };

  // Helper calculation for overall completion
  double get _completionPercentage {
    int totalItems = 3 + _recommendations.length; // 3 core metrics + recommendations
    int completedItems = 0;

    // Core metrics
    if (_heartRate <= 100) completedItems++;
    if (_waterGlasses >= _waterGoal) completedItems++;
    if (_sleepHours >= 7.0) completedItems++;

    // Recommendations list check
    for (var item in _recommendations) {
      if (item['completed'] == true) {
        completedItems++;
      }
    }

    return (completedItems / totalItems) * 100;
  }

  void _triggerScan(String type) {
    setState(() {
      _isScanning = true;
      _showOcrResult = false;
    });

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _isScanning = false;
          _showOcrResult = true;
        });
      }
    });
  }

  void _showEditTrackerDialog(String title, String labelText, String initialValue, Function(String) onSave) {
    final controller = TextEditingController(text: initialValue);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF161C19),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            side: BorderSide(color: const Color(0xFF81C784).withAlpha(50), width: 1.5),
          ),
          title: Text('Update $title', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Enter new reading for your health logs.', style: TextStyle(color: Colors.white70)),
              const SizedBox(height: AppSpacing.md),
              TextField(
                controller: controller,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: labelText,
                  labelStyle: const TextStyle(color: Colors.white54),
                  prefixIcon: const Icon(Icons.edit_calendar, color: Color(0xFF81C784)),
                  filled: true,
                  fillColor: Colors.white.withAlpha(12),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white.withAlpha(20)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFF81C784)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.white54, fontSize: 16)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF81C784),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.radiusPill)),
              ),
              onPressed: () {
                onSave(controller.text);
                Navigator.pop(context);
              },
              child: const Text('Save', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget _buildNeobrutalistCard({
    required Widget child,
    Color backgroundColor = Colors.white,
    double elevation = 2.0,
    double borderSize = 1.8,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black, width: borderSize),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(elevation, elevation * 2),
          ),
        ],
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedMedData = _medicineDb[_selectedMedicine]!;
    final double completionRate = _completionPercentage;

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0A0C16) : const Color(0xFFE8F1F5), // Light sky-blue neobrutalist backdrop
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Health & Wellness',
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

            // Tab Selector
            Container(
              margin: const EdgeInsets.only(bottom: AppSpacing.md),
              padding: const EdgeInsets.all(4),
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
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedTab = 0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: _selectedTab == 0 ? const Color(0xFFC2F3F8) : Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          'AI Health Timeline',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: _selectedTab == 0 ? Colors.black : (isDark ? Colors.white60 : Colors.black54),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedTab = 1),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: _selectedTab == 1 ? const Color(0xFFC2F3F8) : Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          'Health Trends & Vitals',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: _selectedTab == 1 ? Colors.black : (isDark ? Colors.white60 : Colors.black54),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.sm),

            if (_selectedTab == 0) ...[
              // Top Wellness Banner Illustration Card
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
                        'assets/images/branding/wellness_illustration.jpg',
                        height: 145,
                        width: double.infinity,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'AI Health & Care Companion',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Monitor your daily routine and receive smart wellness insights.',
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

              // 1. Daily Health Summary Highlight Card (Cyan)
              _buildNeobrutalistCard(
                backgroundColor: const Color(0xFFC2F3F8), // Cyan neobrutalist
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Today's Summary", 
                          style: TextStyle(fontWeight: FontWeight.w900, color: Colors.black, fontSize: 16),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.black, width: 1.5),
                          ),
                          child: Text(
                            '${completionRate.toStringAsFixed(0)}% Complete',
                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 11),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    // Beautiful progress bar
                    Container(
                      height: 12,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(20),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.black, width: 1.5),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: completionRate / 100.0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFC3F3C0), // Green pastel
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'You have completed ${completionRate.toStringAsFixed(0)}% of today\'s health goals.',
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 15),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      _sleepHours < 7.0 
                          ? '• Try to get at least ${(7.0 - _sleepHours).toStringAsFixed(1)} more hours of sleep.' 
                          : '• Sleep target achieved!',
                      style: const TextStyle(color: Colors.black87, fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _waterGlasses < _waterGoal 
                          ? '• Drink ${_waterGoal - _waterGlasses} more glasses of water.' 
                          : '• Water intake target achieved!',
                      style: const TextStyle(color: Colors.black87, fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      '• Remember to take Vitamin D after lunch.',
                      style: TextStyle(color: Colors.black87, fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // AI Health Timeline
              _buildSectionHeader('AI Health Timeline'),
              _buildNeobrutalistCard(
                backgroundColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.xs),
                  child: Column(
                    children: List.generate(_timelineEvents.length, (index) {
                      return _buildTimelineEventCard(_timelineEvents[index], index == _timelineEvents.length - 1);
                    }),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // 4. Medicine Scanner Simulator
              _buildSectionHeader('Medicine Scanner'),
              _buildNeobrutalistCard(
                backgroundColor: const Color(0xFFFDCBE0), // Pink neobrutalist
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Scan prescriptions or identify medications.',
                      style: TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: [
                        _buildScanButton(
                          label: 'Scan Rx',
                          icon: Icons.qr_code_scanner,
                          onTap: () => _triggerScan('Prescription Scan'),
                        ),
                        _buildScanButton(
                          label: 'Upload Rx',
                          icon: Icons.file_upload,
                          onTap: () => _triggerScan('Document Upload'),
                        ),
                        _buildScanButton(
                          label: 'Take Photo',
                          icon: Icons.camera_alt,
                          onTap: () => _triggerScan('Medicine Photo Capture'),
                        ),
                        _buildScanButton(
                          label: 'Voice Entry',
                          icon: Icons.mic_external_on,
                          onTap: () => _triggerScan('Voice Prescription Entry'),
                        ),
                      ],
                    ),
                    if (_isScanning) ...[
                      const SizedBox(height: AppSpacing.lg),
                      const Column(
                        children: [
                          CircularProgressIndicator(color: Colors.black),
                          SizedBox(height: AppSpacing.sm),
                          Text('Processing prescription...', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black)),
                        ],
                      ),
                    ],
                    if (_showOcrResult && !_isScanning) ...[
                      const SizedBox(height: AppSpacing.lg),
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 1.8),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.check_circle, color: Colors.black),
                                SizedBox(width: AppSpacing.xs),
                                Text('OCR Scan Preview (Simulation)', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 14)),
                              ],
                            ),
                            const Divider(height: 16, thickness: 1.5, color: Colors.black26),
                            const SizedBox(height: AppSpacing.xs),
                            _buildOcrRow('Patient Name:', 'Sarah Jenkins'),
                            _buildOcrRow('Detected Med:', 'Lisinopril 10mg'),
                            _buildOcrRow('Dosage:', 'Take 1 tablet daily by mouth'),
                            _buildOcrRow('Confidence:', '98.4% (Verified)'),
                            const SizedBox(height: AppSpacing.sm),
                            const Text(
                              'Disclaimer: This is a placeholder preview for demo and hackathon presentation.',
                              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black54, fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // 5. Medicine Information Lookup
              _buildSectionHeader('Medicine Information Lookup'),
              _buildNeobrutalistCard(
                backgroundColor: const Color(0xFFFED782), // Yellow neobrutalist
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('Find instructions, details, and warning logs.', style: TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.bold)),
                    const SizedBox(height: AppSpacing.md),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.8),
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedMedicine,
                          isExpanded: true,
                          dropdownColor: Colors.white,
                          icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                          items: _medicineDb.keys.map((String key) {
                            return DropdownMenuItem<String>(
                              value: key,
                              child: Text(key, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black)),
                            );
                          }).toList(),
                          onChanged: (String? val) {
                            if (val != null) {
                              setState(() => _selectedMedicine = val);
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _buildDrugDetails(selectedMedData),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // 6. Voice Medicine Guide
              _buildSectionHeader('Voice Medicine Guide'),
              _buildNeobrutalistCard(
                backgroundColor: const Color(0xFFE5D5FF), // Lilac neobrutalist
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(color: Colors.black, width: 1.5),
                          ),
                          icon: Icon(
                            _isPlayingVoiceGuide ? Icons.stop : Icons.play_arrow,
                            color: Colors.black,
                            size: 32,
                          ),
                          onPressed: () {
                            if (!_isPlayingVoiceGuide) {
                              AudioService().playVoicePlaySound();
                            } else {
                              AudioService().stopVoicePlaySound();
                            }
                            setState(() {
                              _isPlayingVoiceGuide = !_isPlayingVoiceGuide;
                            });
                          },
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _isPlayingVoiceGuide ? 'Playing Guide Audio...' : 'Listen to Audio Instructions',
                                style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: Colors.black),
                              ),
                              const Text(
                                'Voice assistant pronunciation for instructions.',
                                style: TextStyle(color: Colors.black54, fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (_isPlayingVoiceGuide) ...[
                      const SizedBox(height: AppSpacing.md),
                      const VoiceWaveAnimation(color: Color(0xFF69F0AE), height: 40),
                    ],
                    const SizedBox(height: AppSpacing.md),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(120),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.black, width: 1.5),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Text Instructions:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black)),
                          SizedBox(height: AppSpacing.xs),
                          Text('1. Take one tablet after meals.', style: TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.bold)),
                          Text('2. Drink enough water (at least one full glass).', style: TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.bold)),
                          Text('3. Do not skip doses or double up on missed doses.', style: TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
            ] else ...[
              // 2. Health Status
              _buildSectionHeader('Health Status'),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: AppSpacing.md,
                crossAxisSpacing: AppSpacing.md,
                childAspectRatio: 1.45,
                children: [
                  _buildStatusCard(
                    title: 'Heart Health', 
                    value: '$_heartRate bpm', 
                    icon: Icons.favorite_rounded, 
                    color: const Color(0xFFFF5252), // Glowing Red
                    circleColor: const Color(0xFFFF5252).withAlpha(30),
                    badgeText: 'Normal',
                  ),
                  _buildStatusCard(
                    title: 'Blood Pressure', 
                    value: '${_systolic.toStringAsFixed(0)}/${_diastolic.toStringAsFixed(0)}', 
                    icon: Icons.monitor_heart, 
                    color: const Color(0xFF69F0AE), // Glowing Green
                    circleColor: const Color(0xFF69F0AE).withAlpha(30),
                    badgeText: 'Optimal',
                  ),
                  _buildStatusCard(
                    title: 'Hydration', 
                    value: '$_waterGlasses/$_waterGoal glasses', 
                    icon: Icons.water_drop_rounded, 
                    color: const Color(0xFF40C4FF), // Glowing Blue
                    circleColor: const Color(0xFF40C4FF).withAlpha(30),
                    badgeText: _waterGlasses >= 6 ? 'Good' : 'Low',
                  ),
                  _buildStatusCard(
                    title: 'Sleep Quality', 
                    value: '${_sleepHours.toStringAsFixed(1)} hrs', 
                    icon: Icons.bedtime, 
                    color: const Color(0xFF536DFE), // Glowing Purple/Blue
                    circleColor: const Color(0xFF536DFE).withAlpha(30),
                    badgeText: _sleepHours >= 7.0 ? 'Good' : 'Short',
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),

              // 3. Health Tracking
              _buildSectionHeader('Health Metrics Log'),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: AppSpacing.md,
                crossAxisSpacing: AppSpacing.md,
                childAspectRatio: 1.25,
                children: [
                  _buildMetricLogCard(
                    title: 'Heart Rate',
                    value: '$_heartRate bpm',
                    icon: Icons.favorite_rounded,
                    circleColor: const Color(0xFFFF5252).withAlpha(30),
                    color: const Color(0xFFFF5252),
                    onEdit: () => _showEditTrackerDialog('Heart Rate', 'Pulse in bpm', _heartRate.toString(), (val) {
                      final intVal = int.tryParse(val);
                      if (intVal != null) setState(() => _heartRate = intVal);
                    }),
                  ),
                  _buildMetricLogCard(
                    title: 'Blood Pressure',
                    value: '${_systolic.toStringAsFixed(0)}/${_diastolic.toStringAsFixed(0)}',
                    icon: Icons.monitor_heart,
                    circleColor: const Color(0xFF69F0AE).withAlpha(30),
                    color: const Color(0xFF69F0AE),
                    onEdit: () => _showEditTrackerDialog('Blood Pressure', 'Format: Systolic/Diastolic', '${_systolic.toStringAsFixed(0)}/${_diastolic.toStringAsFixed(0)}', (val) {
                      final parts = val.split('/');
                      if (parts.length == 2) {
                        final s = double.tryParse(parts[0]);
                        final d = double.tryParse(parts[1]);
                        if (s != null && d != null) {
                          setState(() {
                            _systolic = s;
                            _diastolic = d;
                          });
                        }
                      }
                    }),
                  ),
                  _buildMetricLogCard(
                    title: 'Blood Sugar',
                    value: '$_bloodSugar mg/dL',
                    icon: Icons.water_drop,
                    circleColor: const Color(0xFFFFAB40).withAlpha(30),
                    color: const Color(0xFFFFAB40),
                    onEdit: () => _showEditTrackerDialog('Blood Sugar', 'Sugar level in mg/dL', _bloodSugar.toString(), (val) {
                      final intVal = int.tryParse(val);
                      if (intVal != null) setState(() => _bloodSugar = intVal);
                    }),
                  ),
                  _buildMetricLogCard(
                    title: 'Body Temperature',
                    value: '${_temperature.toStringAsFixed(1)} °F',
                    icon: Icons.thermostat,
                    circleColor: const Color(0xFFFF9800).withAlpha(30),
                    color: const Color(0xFFFF9800),
                    onEdit: () => _showEditTrackerDialog('Body Temperature', 'Temperature in °F', _temperature.toString(), (val) {
                      final doubleVal = double.tryParse(val);
                      if (doubleVal != null) setState(() => _temperature = doubleVal);
                    }),
                  ),
                  _buildMetricLogCard(
                    title: 'Water Intake',
                    value: '$_waterGlasses / $_waterGoal',
                    icon: Icons.water_drop_outlined,
                    circleColor: const Color(0xFF40C4FF).withAlpha(30),
                    color: const Color(0xFF40C4FF),
                    onEdit: () => _showEditTrackerDialog('Water Glasses', 'Number of glasses', _waterGlasses.toString(), (val) {
                      final intVal = int.tryParse(val);
                      if (intVal != null) setState(() => _waterGlasses = intVal);
                    }),
                  ),
                  _buildMetricLogCard(
                    title: 'Sleep Duration',
                    value: '${_sleepHours.toStringAsFixed(1)} hrs',
                    icon: Icons.bedtime,
                    circleColor: const Color(0xFF536DFE).withAlpha(30),
                    color: const Color(0xFF536DFE),
                    onEdit: () => _showEditTrackerDialog('Sleep Hours', 'Sleep duration in hours', _sleepHours.toString(), (val) {
                      final doubleVal = double.tryParse(val);
                      if (doubleVal != null) setState(() => _sleepHours = doubleVal);
                    }),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),

              // 8. Health Recommendations List
              _buildSectionHeader('Health Recommendations'),
              _buildNeobrutalistCard(
                backgroundColor: const Color(0xFFFED782), // Yellow neobrutalist
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('Check off tasks as you complete them to track daily wellness.', style: TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.bold)),
                    const SizedBox(height: AppSpacing.md),
                    ..._recommendations.asMap().entries.map((entry) {
                      final index = entry.key;
                      final rec = entry.value;
                      return Theme(
                        data: ThemeData.light(),
                        child: Material(
                          color: Colors.transparent,
                          child: CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(rec['text'], style: TextStyle(
                              decoration: rec['completed'] ? TextDecoration.lineThrough : null,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 15,
                            )),
                            subtitle: Text(rec['desc'], style: const TextStyle(fontSize: 12, color: Colors.black87)),
                            value: rec['completed'],
                            activeColor: Colors.black,
                            checkColor: Colors.white,
                            onChanged: (bool? val) {
                              if (val != null) {
                                setState(() {
                                  _recommendations[index]['completed'] = val;
                                });
                              }
                            },
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
            ],

            // 9. Coming Soon Section Roadmap Cards
            _buildSectionHeader('Roadmap & Future Integrations'),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: AppSpacing.md,
              crossAxisSpacing: AppSpacing.md,
              childAspectRatio: 1.35,
              children: [
                _buildComingSoonCard('OCR Prescriptions', Icons.document_scanner),
                _buildComingSoonCard('Interaction Checker', Icons.compare_arrows),
                _buildComingSoonCard('Wearable Integration', Icons.watch),
                _buildComingSoonCard('Smart Watch Support', Icons.watch_rounded),
                _buildComingSoonCard('Hospital System Link', Icons.local_hospital),
                _buildComingSoonCard('Doctor Portal Access', Icons.badge_outlined),
                _buildComingSoonCard('Family Dashboard', Icons.people),
                _buildComingSoonCard('Medicine Delivery', Icons.local_shipping),
              ],
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required Color circleColor,
    required String badgeText,
  }) {
    Color cardBgColor = Colors.white;
    if (title.contains('Heart')) {
      cardBgColor = const Color(0xFFFDCBE0); // Pink
    } else if (title.contains('Pressure')) {
      cardBgColor = const Color(0xFFC3F3C0); // Green
    } else if (title.contains('Hydration')) {
      cardBgColor = const Color(0xFFC2F3F8); // Cyan
    } else if (title.contains('Sleep')) {
      cardBgColor = const Color(0xFFE5D5FF); // Lilac
    }

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black, width: 1.8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            offset: Offset(2, 4),
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
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 1.5),
                ),
                child: Center(
                  child: Icon(icon, color: Colors.black, size: 16),
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  title, 
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 11),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            value, 
            style: const TextStyle(fontWeight: FontWeight.w900, color: Colors.black, fontSize: 16),
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                badgeText, 
                style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricLogCard({
    required String title,
    required String value,
    required IconData icon,
    required Color circleColor,
    required Color color,
    required VoidCallback onEdit,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black, width: 1.8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            child: CircleAvatar(
              radius: 13,
              backgroundColor: Colors.black.withAlpha(20),
              child: IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.edit, size: 13, color: Colors.black),
                onPressed: onEdit,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 1.5),
                ),
                child: Center(
                  child: Icon(icon, color: Colors.black, size: 18),
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                title, 
                style: const TextStyle(color: Colors.black54, fontSize: 11, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                value, 
                style: const TextStyle(fontWeight: FontWeight.w900, color: Colors.black, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildComingSoonCard(String title, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black, width: 1.8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(10),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 1.5),
            ),
            child: const Center(
              child: Icon(Icons.star_outline_rounded, color: Colors.black, size: 18),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            title, 
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black87),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: const Color(0xFFC3F3C0), // Green pastel
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black, width: 1.5),
            ),
            child: const Text(
              'Coming Soon',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScanButton({required String label, required IconData icon, required VoidCallback onTap}) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        side: const BorderSide(color: Colors.black, width: 1.8),
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      ),
      onPressed: onTap,
      icon: Icon(icon, size: 18, color: Colors.black),
      label: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black)),
    );
  }

  Widget _buildOcrRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 12)),
          const SizedBox(width: AppSpacing.xs),
          Text(value, style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildDrugDetails(Map<String, String> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDrugDetailRow('Purpose:', data['purpose']!),
        _buildDrugDetailRow('Uses:', data['uses']!),
        _buildDrugDetailRow('Benefits:', data['benefits']!),
        _buildDrugDetailRow('Side Effects:', data['sideEffects']!),
        _buildDrugDetailRow('Warnings:', data['warnings']!),
        _buildDrugDetailRow('Food Restrictions:', data['foodRestrictions']!),
        _buildDrugDetailRow('Storage Instructions:', data['storage']!),
        _buildDrugDetailRow('Age-wise Dosage:', data['dosage']!),
        const SizedBox(height: AppSpacing.sm),
        Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black, width: 1.5),
          ),
          child: const Text(
            'Disclaimer: For informational purposes only. Consult a healthcare provider.',
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDrugDetailRow(String label, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 13)),
          const SizedBox(height: 2),
          Text(text, style: const TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildTimelineEventCard(Map<String, dynamic> event, bool isLast) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Left: Node line & Circle
          Column(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: Icon(event['icon'], color: Colors.black, size: 16),
              ),
              if (!isLast)
                Expanded(
                  child: Center(
                    child: Container(
                      width: 2.5,
                      color: Colors.black26,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: AppSpacing.md),
          // Right: Content Card
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        event['title'],
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 15,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      event['time'],
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  event['subtitle'],
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 13,
                    height: 1.3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20), // Spacing between nodes
              ],
            ),
          ),
        ],
      ),
    );
  }
}
