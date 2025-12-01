class VisitorDetailModel {
  VisitorDetailModel({
    required this.visitorName,
    required this.companyName,
    required this.registerDate,
    required this.cardNumber,
    required this.contact,
    required this.registeredSystemName,
  });

  final String? visitorName;
  final String? companyName;
  final DateTime? registerDate;
  final String? cardNumber;
  final String? contact;
  final String? registeredSystemName;

  factory VisitorDetailModel.fromJson(Map<String, dynamic> json){
    return VisitorDetailModel(
      visitorName: json["Visitor Name"],
      companyName: json["Company Name"],
      registerDate: DateTime.tryParse(json["Register Date"] ?? ""),
      cardNumber: json["Card Number"],
      contact: json["Contact"],
      registeredSystemName: json["Registered System Name"],
    );
  }

}
