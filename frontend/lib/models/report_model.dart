/// Matches backend report response (build_report helper).
class ReportModel {
  final int periodDays;
  final int activeMedicines;
  final int healthLogsRecorded;
  final double? averageSugarLevel;
  final double? averageWeight;
  final double? averageSleepHours;
  final int upcomingAppointments;
  final int sosTriggers;

  const ReportModel({
    required this.periodDays,
    required this.activeMedicines,
    required this.healthLogsRecorded,
    this.averageSugarLevel,
    this.averageWeight,
    this.averageSleepHours,
    required this.upcomingAppointments,
    required this.sosTriggers,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      periodDays: json['period_days'] as int? ?? 0,
      activeMedicines: json['active_medicines'] as int? ?? 0,
      healthLogsRecorded: json['health_logs_recorded'] as int? ?? 0,
      averageSugarLevel: (json['average_sugar_level'] as num?)?.toDouble(),
      averageWeight: (json['average_weight'] as num?)?.toDouble(),
      averageSleepHours: (json['average_sleep_hours'] as num?)?.toDouble(),
      upcomingAppointments: json['upcoming_appointments'] as int? ?? 0,
      sosTriggers: json['sos_triggers'] as int? ?? 0,
    );
  }

  /// Returns 'N/A' for null values, formatted number otherwise.
  String get sugarDisplay => averageSugarLevel != null
      ? '${averageSugarLevel!.toStringAsFixed(1)} mg/dL'
      : 'N/A';

  String get weightDisplay => averageWeight != null
      ? '${averageWeight!.toStringAsFixed(1)} kg'
      : 'N/A';

  String get sleepDisplay => averageSleepHours != null
      ? '${averageSleepHours!.toStringAsFixed(1)} hrs'
      : 'N/A';
}
