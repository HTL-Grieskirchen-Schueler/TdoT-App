class TrialDayRegistration {
  final String school;
  final String name;
  final String email;
  final String phone;

  String? error;

  TrialDayRegistration({
    required this.name,
    required this.school,
    required this.email,
    required this.phone,
  });

  factory TrialDayRegistration.fromJson(Map<String, dynamic> json) {
    return TrialDayRegistration(
      name: json['name'],
      school: json['school'],
      email: json['email'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'school': school,
      'email': email,
      'phone': phone,
    };
  }
}
