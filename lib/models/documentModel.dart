
class DocumentModel {
  final String passportNumber;
  final String name;
  final String yellowFeverCard;
  final String visa;
  final String status;
  final String type;

  DocumentModel({
    required this.passportNumber,
    required this.name,
    required this.yellowFeverCard,
    required this.visa,
    required this.type,
    required this.status,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      passportNumber: json['passportNumber'],
      name: json['name'],
      yellowFeverCard: json['yellowFeverCard'],
      visa: json['visa'],
      type: json['type'],
      status: json['status'],
    );
  }
}