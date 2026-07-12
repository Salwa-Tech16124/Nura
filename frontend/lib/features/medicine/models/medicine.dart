class Medicine {
  final int? id;
  final String name;
  final String dosage;
  final String frequency;
  final String? time;
  final String? notes;
  final bool isActive;

  Medicine({
    this.id,
    required this.name,
    required this.dosage,
    required this.frequency,
    this.time,
    this.notes,
    this.isActive = true,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id: json['id'],
      name: json['name'] ?? '',
      dosage: json['dosage'] ?? '',
      frequency: json['frequency'] ?? 'Daily',
      time: json['time'],
      notes: json['notes'],
      isActive: json['is_active'] ?? true,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'dosage': dosage,
        'frequency': frequency,
        if (time != null) 'time': time,
        if (notes != null) 'notes': notes,
        'is_active': isActive,
      };

  Medicine copyWith({
    int? id,
    String? name,
    String? dosage,
    String? frequency,
    String? time,
    String? notes,
    bool? isActive,
  }) {
    return Medicine(
      id: id ?? this.id,
      name: name ?? this.name,
      dosage: dosage ?? this.dosage,
      frequency: frequency ?? this.frequency,
      time: time ?? this.time,
      notes: notes ?? this.notes,
      isActive: isActive ?? this.isActive,
    );
  }
}
