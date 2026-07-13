import 'dart:convert';

/// Matches backend UserResponse schema.
class UserModel {
  final int id;
  final String name;
  final int? age;
  final String? gender;
  final String phoneNumber;
  final String? emergencyContact;
  final String email;

  const UserModel({
    required this.id,
    required this.name,
    this.age,
    this.gender,
    required this.phoneNumber,
    this.emergencyContact,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      name: json['name'] as String,
      age: json['age'] as int?,
      gender: json['gender'] as String?,
      phoneNumber: json['phone_number'] as String,
      emergencyContact: json['emergency_contact'] as String?,
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'age': age,
        'gender': gender,
        'phone_number': phoneNumber,
        'emergency_contact': emergencyContact,
        'email': email,
      };

  String toJsonString() => jsonEncode(toJson());

  static UserModel? fromJsonString(String? jsonStr) {
    if (jsonStr == null || jsonStr.isEmpty) return null;
    try {
      return UserModel.fromJson(jsonDecode(jsonStr) as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  UserModel copyWith({
    int? id,
    String? name,
    int? age,
    String? gender,
    String? phoneNumber,
    String? emergencyContact,
    String? email,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      email: email ?? this.email,
    );
  }
}
