/// Matches backend HealthLogResponse schema.
class HealthLogModel {
  final int? id;
  final int? userId;
  final String? bloodPressure;
  final double? sugarLevel;
  final double? weight;
  final double? sleepHours;
  final String? mood;
  final String? symptoms;
  final int? heartRate;
  final double? caloriesBurned;
  final int? steps;
  final DateTime? loggedAt;

  const HealthLogModel({
    this.id,
    this.userId,
    this.bloodPressure,
    this.sugarLevel,
    this.weight,
    this.sleepHours,
    this.mood,
    this.symptoms,
    this.heartRate,
    this.caloriesBurned,
    this.steps,
    this.loggedAt,
  });

  factory HealthLogModel.fromJson(Map<String, dynamic> json) {
    return HealthLogModel(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      bloodPressure: json['blood_pressure'] as String?,
      sugarLevel: (json['sugar_level'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
      sleepHours: (json['sleep_hours'] as num?)?.toDouble(),
      mood: json['mood'] as String?,
      symptoms: json['symptoms'] as String?,
      heartRate: json['heart_rate'] as int?,
      caloriesBurned: (json['calories_burned'] as num?)?.toDouble(),
      steps: json['steps'] as int?,
      loggedAt: json['logged_at'] != null
          ? DateTime.tryParse(json['logged_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        if (bloodPressure != null) 'blood_pressure': bloodPressure,
        if (sugarLevel != null) 'sugar_level': sugarLevel,
        if (weight != null) 'weight': weight,
        if (sleepHours != null) 'sleep_hours': sleepHours,
        if (mood != null) 'mood': mood,
        if (symptoms != null) 'symptoms': symptoms,
        if (heartRate != null) 'heart_rate': heartRate,
        if (caloriesBurned != null) 'calories_burned': caloriesBurned,
        if (steps != null) 'steps': steps,
      };
}
