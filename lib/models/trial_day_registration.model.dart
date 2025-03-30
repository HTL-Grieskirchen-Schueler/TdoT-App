class TrialDayRegistration {
  final DateTime date;
  final String school;
  final String name;
  final String email;
  final String phone;

  TrialDayRegistration({
    required this.date,
    required this.name,
    required this.school,
    required this.email,
    required this.phone,
  });

  factory TrialDayRegistration.fromJson(Map<String, dynamic> json) {
    return TrialDayRegistration(
      date: DateTime.parse(json['date']),
      name: json['name'],
      school: json['school'],
      email: json['email'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String().split('T').first,
      'name': name,
      'school': school,
      'email': email,
      'phone': phone,
    };
  }
}
