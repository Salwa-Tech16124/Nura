class RegisterRequest {
  final String name;
  final String email;
  final String phoneNumber;
  final String password;
  final int? age;
  final String? gender;
  final String? emergencyContact;

  RegisterRequest({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.password,
    this.age,
    this.gender,
    this.emergencyContact,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'phone_number': phoneNumber,
        'password': password,
        'age': age,
        'gender': gender,
        'emergency_contact': emergencyContact,
      };
}
