class LoggedInUserModel {
  final String id;
  final String username, fullName;
  final String email;

  LoggedInUserModel(
      {required this.id,
      required this.username,
      required this.fullName,
      required this.email});

  factory LoggedInUserModel.fromJson(Map<String, dynamic> json) {
    return LoggedInUserModel(
      id: json['_id'],
      username: json['username'],
      fullName: json['fullName'],
      email: json['email'],
    );
  }
}
