/// Matches backend MedicineResponse schema.
class MedicineModel {
  final int? id;
  final int? userId;
  final String medicineName;
  final String? dosage;
  final String? frequency;
  final String? time;
  final String? startDate;
  final String? endDate;

  const MedicineModel({
    this.id,
    this.userId,
    required this.medicineName,
    this.dosage,
    this.frequency,
    this.time,
    this.startDate,
    this.endDate,
  });

  factory MedicineModel.fromJson(Map<String, dynamic> json) {
    return MedicineModel(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      medicineName: json['medicine_name'] as String,
      dosage: json['dosage'] as String?,
      frequency: json['frequency'] as String?,
      time: json['time'] as String?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'medicine_name': medicineName,
        if (dosage != null) 'dosage': dosage,
        if (frequency != null) 'frequency': frequency,
        if (time != null) 'time': time,
        if (startDate != null) 'start_date': startDate,
        if (endDate != null) 'end_date': endDate,
      };

  MedicineModel copyWith({
    int? id,
    int? userId,
    String? medicineName,
    String? dosage,
    String? frequency,
    String? time,
    String? startDate,
    String? endDate,
  }) {
    return MedicineModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      medicineName: medicineName ?? this.medicineName,
      dosage: dosage ?? this.dosage,
      frequency: frequency ?? this.frequency,
      time: time ?? this.time,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}
