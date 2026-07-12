class UserProfile {
  final int id;
  final String name;
  final String email;
  final String phoneNumber;
  final int? age;
  final String? gender;
  final String? emergencyContact;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.age,
    this.gender,
    this.emergencyContact,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      age: json['age'],
      gender: json['gender'],
      emergencyContact: json['emergency_contact'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone_number': phoneNumber,
        'age': age,
        'gender': gender,
        'emergency_contact': emergencyContact,
      };
}
