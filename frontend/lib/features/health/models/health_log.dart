class HealthLog {
  final int? id;
  final String metricType;
  final String value;
  final String? unit;
  final String? notes;
  final DateTime loggedAt;

  HealthLog({
    this.id,
    required this.metricType,
    required this.value,
    this.unit,
    this.notes,
    required this.loggedAt,
  });

  factory HealthLog.fromJson(Map<String, dynamic> json) {
    return HealthLog(
      id: json['id'],
      metricType: json['metric_type'] ?? '',
      value: json['value']?.toString() ?? '',
      unit: json['unit'],
      notes: json['notes'],
      loggedAt: json['logged_at'] != null
          ? DateTime.tryParse(json['logged_at']) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'metric_type': metricType,
        'value': value,
        if (unit != null) 'unit': unit,
        if (notes != null) 'notes': notes,
        'logged_at': loggedAt.toIso8601String(),
      };
}
