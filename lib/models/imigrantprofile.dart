class ImmigrantProfile {
  final String immigrantId;
  final String name;
  final String nationality;
  final String email;
  final String placeOfBirth;
  final String dateOfBirth;
  final String passportNumber;
  final String phoneNumber;

  ImmigrantProfile({
    required this.immigrantId,
    required this.name,
    required this.nationality,
    required this.email,
    required this.placeOfBirth,
    required this.dateOfBirth,
    required this.passportNumber,
    required this.phoneNumber,
  });

  factory ImmigrantProfile.fromJson(Map<String, dynamic> json) {
    return ImmigrantProfile(
      immigrantId: json['id'].toString(),
      name: json['fullName'],
      nationality: json['nationality'],
      email: json['email'],
      passportNumber: json['passportNumber']??'',
      dateOfBirth: json['dateOfBirth'],
      placeOfBirth: json['placeOfBirth'],
      phoneNumber: json['phoneNumber'],
    );
  }
}
