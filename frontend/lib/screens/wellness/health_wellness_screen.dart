import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_spacing.dart';
import '../../widgets/layout/page_container.dart';
import '../../widgets/cards.dart';
import '../../widgets/voice_wave_animation.dart';

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
  int _dailySteps = 6800;
  int _stepGoal = 8000;
  int _caloriesBurned = 350;
  int _waterGlasses = 6;
  final int _waterGoal = 8;
  double _sleepHours = 7.5;

  // 2. Recommendations State (Checklist)
  final List<Map<String, dynamic>> _recommendations = [
    {'text': 'Walk 30 minutes today', 'completed': false, 'desc': 'Completing this completes your step goal.'},
    {'text': 'Drink more water', 'completed': false, 'desc': 'Need 2 more glasses.'},
    {'text': 'Reduce sugar intake', 'completed': false, 'desc': 'Avoid sugary snacks after lunch.'},
    {'text': 'Sleep before 11 PM', 'completed': false, 'desc': 'Essential for sleep cycle.'},
    {'text': 'Check blood pressure tomorrow', 'completed': false, 'desc': 'Keep tracking daily trends.'},
  ];

  // 3. Simulated Medicine Guide Voice Playback
  bool _isPlayingVoiceGuide = false;

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
    if (_dailySteps >= _stepGoal) completedItems++;
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
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedMedData = _medicineDb[_selectedMedicine]!;
    final double completionRate = _completionPercentage;

    return Scaffold(
      backgroundColor: const Color(0xFF0F1311), // Premium dark charcoal sage backdrop
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Health & Wellness',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => context.go('/home'),
        ),
      ),
      body: PageContainer(
        child: ScrollablePageLayout(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppSpacing.sm),

            // 1. Daily Health Summary Highlight Card (Dark Sage-Green)
            BaseCard(
              backgroundColor: const Color(0xFF1B221E), // Dark translucent sage card
              borderRadius: BorderRadius.circular(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Today's Summary", 
                        style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white, fontSize: 16),
                      ),
                      // Soft Green "Pro" style badge matching Image 2 details
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF81C784).withAlpha(40), // Translucent green
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFF81C784).withAlpha(120), width: 1.0),
                        ),
                        child: Text(
                          '${completionRate.toStringAsFixed(0)}% Complete',
                          style: const TextStyle(color: Color(0xFFA5D6A7), fontWeight: FontWeight.bold, fontSize: 11),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  // Beautiful glowing green/sage progress bar
                  Container(
                    height: 10,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(15),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: completionRate / 100.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF81C784), Color(0xFF2E7D32)], // Sage to Forest Green
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'You have completed ${completionRate.toStringAsFixed(0)}% of today\'s health goals.',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 15),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    _dailySteps < _stepGoal 
                        ? '• Walk another ${_stepGoal - _dailySteps} steps.' 
                        : '• Steps goal achieved!',
                    style: const TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                  Text(
                    _waterGlasses < _waterGoal 
                        ? '• Drink ${_waterGoal - _waterGlasses} more glasses of water.' 
                        : '• Water intake target achieved!',
                    style: const TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                  const Text(
                    '• Remember to take Vitamin D after lunch.',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

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
                  title: 'Activity Level', 
                  value: '$_dailySteps steps', 
                  icon: Icons.directions_walk, 
                  color: const Color(0xFFE040FB), // Glowing Purple
                  circleColor: const Color(0xFFE040FB).withAlpha(30),
                  badgeText: _dailySteps >= 6000 ? 'Active' : 'Moderate',
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
                  title: 'Daily Steps',
                  value: '$_dailySteps / $_stepGoal',
                  icon: Icons.directions_walk,
                  circleColor: const Color(0xFFE040FB).withAlpha(30),
                  color: const Color(0xFFE040FB),
                  onEdit: () => _showEditTrackerDialog('Daily Steps', 'Steps count', _dailySteps.toString(), (val) {
                    final intVal = int.tryParse(val);
                    if (intVal != null) setState(() => _dailySteps = intVal);
                  }),
                ),
                _buildMetricLogCard(
                  title: 'Calories Burned',
                  value: '$_caloriesBurned kcal',
                  icon: Icons.local_fire_department,
                  circleColor: const Color(0xFFFFD740).withAlpha(30),
                  color: const Color(0xFFFFD740),
                  onEdit: () => _showEditTrackerDialog('Calories Burned', 'Calories in kcal', _caloriesBurned.toString(), (val) {
                    final intVal = int.tryParse(val);
                    if (intVal != null) setState(() => _caloriesBurned = intVal);
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
                _buildMetricLogCard(
                  title: 'Step Goal',
                  value: '$_stepGoal steps',
                  icon: Icons.flag_circle,
                  circleColor: const Color(0xFF69F0AE).withAlpha(30),
                  color: const Color(0xFF69F0AE),
                  onEdit: () => _showEditTrackerDialog('Step Goal', 'Goal steps', _stepGoal.toString(), (val) {
                    final intVal = int.tryParse(val);
                    if (intVal != null) setState(() => _stepGoal = intVal);
                  }),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),

            // 4. Medicine Scanner Simulator
            _buildSectionHeader('Medicine Scanner'),
            BaseCard(
              backgroundColor: const Color(0xFF1B221E),
              borderRadius: BorderRadius.circular(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Scan prescriptions or identify medications.',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
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
                        CircularProgressIndicator(color: Color(0xFF81C784)),
                        const SizedBox(height: AppSpacing.sm),
                        Text('Processing prescription...', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white)),
                      ],
                    ),
                  ],
                  if (_showOcrResult && !_isScanning) ...[
                    const SizedBox(height: AppSpacing.lg),
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: const Color(0xFF161C19),
                        border: Border.all(color: const Color(0xFF81C784).withAlpha(120), width: 1.5),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.check_circle, color: Color(0xFF69F0AE)),
                              SizedBox(width: AppSpacing.xs),
                              Text('OCR Scan Preview (Simulation)', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF69F0AE), fontSize: 14)),
                            ],
                          ),
                          const Divider(height: 16, thickness: 1, color: Colors.white12),
                          const SizedBox(height: AppSpacing.xs),
                          _buildOcrRow('Patient Name:', 'Sarah Jenkins'),
                          _buildOcrRow('Detected Med:', 'Lisinopril 10mg'),
                          _buildOcrRow('Dosage:', 'Take 1 tablet daily by mouth'),
                          _buildOcrRow('Confidence:', '98.4% (Verified)'),
                          const SizedBox(height: AppSpacing.sm),
                          const Text(
                            'Disclaimer: This is a placeholder preview for demo and hackathon presentation.',
                            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white38, fontSize: 11),
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
            BaseCard(
              backgroundColor: const Color(0xFF1B221E),
              borderRadius: BorderRadius.circular(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Find instructions, details, and warning logs.', style: TextStyle(color: Colors.white70, fontSize: 14)),
                  const SizedBox(height: AppSpacing.md),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white.withAlpha(15)),
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white.withAlpha(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedMedicine,
                        isExpanded: true,
                        dropdownColor: const Color(0xFF161C19),
                        icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF81C784)),
                        items: _medicineDb.keys.map((String key) {
                          return DropdownMenuItem<String>(
                            value: key,
                            child: Text(key, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white)),
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
                  // Render drug specs
                  _buildDrugDetails(selectedMedData),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // 6. Voice Medicine Guide
            _buildSectionHeader('Voice Medicine Guide'),
            BaseCard(
              backgroundColor: const Color(0xFF1B221E),
              borderRadius: BorderRadius.circular(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: const Color(0xFF81C784).withAlpha(40),
                        ),
                        icon: Icon(
                          _isPlayingVoiceGuide ? Icons.stop : Icons.play_arrow,
                          color: const Color(0xFF69F0AE),
                          size: 32,
                        ),
                        onPressed: () {
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
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
                            ),
                            const Text(
                              'Voice assistant pronunciation for instructions.',
                              style: TextStyle(color: Colors.white70, fontSize: 12),
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
                      color: Colors.white.withAlpha(8),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white.withAlpha(10)),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Text Instructions:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white)),
                        SizedBox(height: AppSpacing.xs),
                        Text('1. Take one tablet after meals.', style: TextStyle(fontSize: 13, color: Colors.white70)),
                        Text('2. Drink enough water (at least one full glass).', style: TextStyle(fontSize: 13, color: Colors.white70)),
                        Text('3. Do not skip doses or double up on missed doses.', style: TextStyle(fontSize: 13, color: Colors.white70)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // 7. Diet & Nutrition
            _buildSectionHeader('Diet & Nutrition Planner'),
            BaseCard(
              backgroundColor: const Color(0xFF1B221E),
              borderRadius: BorderRadius.circular(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildDietMetricCard('1,800 kcal', 'Daily Calories'),
                      _buildDietMetricCard('22.5', 'BMI (Normal)'),
                      _buildDietMetricCard('1.5 / 2.0 L', 'Water Level'),
                    ],
                  ),
                  const Divider(height: 24, thickness: 1, color: Colors.white24),
                  const Text('Daily Recommended Meals', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white)),
                  const SizedBox(height: AppSpacing.sm),
                  _buildMealRow('Breakfast', 'Oatmeal with fresh blueberries & organic chia seeds.'),
                  _buildMealRow('Lunch', 'Grilled free-range chicken breast with mixed garden green salad.'),
                  _buildMealRow('Dinner', 'Baked Atlantic salmon with fresh steamed broccoli.'),
                  _buildMealRow('Healthy Snacks', 'Handful of unsalted raw almonds & Greek yogurt.'),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Foods to Eat', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF69F0AE), fontSize: 13)),
                            const SizedBox(height: AppSpacing.xs),
                            _buildFoodListItem(Icons.check_circle_outline, 'Spinach & kale', const Color(0xFF69F0AE)),
                            _buildFoodListItem(Icons.check_circle_outline, 'Whole grain oats', const Color(0xFF69F0AE)),
                            _buildFoodListItem(Icons.check_circle_outline, 'Salmon & mackerel', const Color(0xFF69F0AE)),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Foods to Avoid', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFF5252), fontSize: 13)),
                            const SizedBox(height: AppSpacing.xs),
                            _buildFoodListItem(Icons.cancel_outlined, 'Processed sugars', const Color(0xFFFF5252)),
                            _buildFoodListItem(Icons.cancel_outlined, 'Excess sodium/salt', const Color(0xFFFF5252)),
                            _buildFoodListItem(Icons.cancel_outlined, 'Saturated trans fats', const Color(0xFFFF5252)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // 8. Health Recommendations List (Checklist updates completion rate)
            _buildSectionHeader('Health Recommendations'),
            BaseCard(
              backgroundColor: const Color(0xFF1B221E),
              borderRadius: BorderRadius.circular(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Check off tasks as you complete them to track daily wellness.', style: TextStyle(color: Colors.white70, fontSize: 14)),
                  const SizedBox(height: AppSpacing.md),
                  ..._recommendations.asMap().entries.map((entry) {
                    final index = entry.key;
                    final rec = entry.value;
                    return Theme(
                      data: ThemeData.dark(),
                      child: CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(rec['text'], style: TextStyle(
                          decoration: rec['completed'] ? TextDecoration.lineThrough : null,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 15,
                        )),
                        subtitle: Text(rec['desc'], style: const TextStyle(fontSize: 12, color: Colors.white54)),
                        value: rec['completed'],
                        activeColor: const Color(0xFF69F0AE), // Neon green active checkbox
                        onChanged: (bool? val) {
                          if (val != null) {
                            setState(() {
                              _recommendations[index]['completed'] = val;
                            });
                          }
                        },
                      ),
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

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
    return BaseCard(
      backgroundColor: const Color(0xFF1B221E),
      borderRadius: BorderRadius.circular(24),
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
                  color: circleColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(icon, color: color, size: 16),
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  title, 
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white60, fontSize: 11),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            value, 
            style: const TextStyle(fontWeight: FontWeight.w900, color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                badgeText, 
                style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 11),
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
    return BaseCard(
      backgroundColor: const Color(0xFF1B221E),
      borderRadius: BorderRadius.circular(24),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            child: CircleAvatar(
              radius: 13,
              backgroundColor: Colors.white.withAlpha(10),
              child: IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.edit, size: 13, color: Color(0xFFA5D6A7)),
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
                  color: circleColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(icon, color: color, size: 18),
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                title, 
                style: const TextStyle(color: Colors.white60, fontSize: 11, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                value, 
                style: const TextStyle(fontWeight: FontWeight.w900, color: Colors.white, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildComingSoonCard(String title, IconData icon) {
    return BaseCard(
      backgroundColor: const Color(0xFF1B221E),
      borderRadius: BorderRadius.circular(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(10),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(Icons.star_outline_rounded, color: Color(0xFFA5D6A7), size: 18),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            title, 
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white70),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: const Color(0xFF81C784).withAlpha(40),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF81C784).withAlpha(120), width: 1.0),
            ),
            child: const Text(
              'Coming Soon',
              style: TextStyle(color: Color(0xFFA5D6A7), fontWeight: FontWeight.bold, fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScanButton({required String label, required IconData icon, required VoidCallback onTap}) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withAlpha(10),
        foregroundColor: Colors.white,
        side: BorderSide(color: const Color(0xFF81C784).withAlpha(100), width: 1.5),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      ),
      onPressed: onTap,
      icon: Icon(icon, size: 18, color: const Color(0xFF69F0AE)),
      label: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white)),
    );
  }

  Widget _buildOcrRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white70, fontSize: 12)),
          const SizedBox(width: AppSpacing.xs),
          Text(value, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildDietMetricCard(String value, String label) {
    return Expanded(
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF69F0AE), fontSize: 18)),
          Text(label, style: const TextStyle(fontSize: 11, color: Colors.white60), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildMealRow(String label, String details) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF69F0AE), fontSize: 13)),
          Text(details, style: const TextStyle(fontSize: 13, color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _buildFoodListItem(IconData icon, String text, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: AppSpacing.xs),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 12, color: Colors.white70))),
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
            color: const Color(0xFFFFD740).withAlpha(30),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFFFD740).withAlpha(120)),
          ),
          child: const Text(
            'Disclaimer: For informational purposes only. Consult a healthcare provider.',
            style: TextStyle(
              color: Color(0xFFFFD740),
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
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF69F0AE), fontSize: 13)),
          const SizedBox(height: 2),
          Text(text, style: const TextStyle(fontSize: 13, color: Colors.white70)),
        ],
      ),
    );
  }
}
