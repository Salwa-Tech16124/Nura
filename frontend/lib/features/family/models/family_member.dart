class FamilyMember {
  final int? id;
  final String name;
  final String relationship;
  final String phoneNumber;
  final String? email;

  FamilyMember({
    this.id,
    required this.name,
    required this.relationship,
    required this.phoneNumber,
    this.email,
  });

  factory FamilyMember.fromJson(Map<String, dynamic> json) {
    return FamilyMember(
      id: json['id'],
      name: json['name'] ?? '',
      relationship: json['relationship'] ?? '',
      phoneNumber: json['phone_number'] ?? json['phone'] ?? '',
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'relationship': relationship,
        'phone_number': phoneNumber,
        if (email != null) 'email': email,
      };

  FamilyMember copyWith({
    int? id,
    String? name,
    String? relationship,
    String? phoneNumber,
    String? email,
  }) {
    return FamilyMember(
      id: id ?? this.id,
      name: name ?? this.name,
      relationship: relationship ?? this.relationship,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
    );
  }
}
