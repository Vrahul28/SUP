// class Staff {
//   String? staffId;
//   String? activationDate;
//   String? company;
//   String? expirationDate;
//   String? firstName;
//   String? lastName;
//   String? companyId;
//   String? cardNumber;
//   String? imageData;
//   String? towerIds;
//
//   Staff(
//       {this.staffId,
//         this.activationDate,
//         this.company,
//         this.expirationDate,
//         this.firstName,
//         this.lastName,
//         this.companyId,
//         this.cardNumber,
//         this.imageData,
//         this.towerIds});
//
//   Staff.fromJson(Map<String, dynamic> json) {
//     staffId = json['staff_id'];
//     activationDate = json['activation_date'];
//     company = json['company'];
//     expirationDate = json['expiration_date'];
//     firstName = json['first_name'];
//     lastName = json['last_name'];
//     companyId = json['company_id'];
//     cardNumber = json['card_number'];
//     imageData = json['image_data'];
//     towerIds = json['tower_ids'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['staff_id'] = this.staffId;
//     data['activation_date'] = this.activationDate;
//     data['company'] = this.company;
//     data['expiration_date'] = this.expirationDate;
//     data['first_name'] = this.firstName;
//     data['last_name'] = this.lastName;
//     data['company_id'] = this.companyId;
//     data['card_number'] = this.cardNumber;
//     data['image_data'] = this.imageData;
//     data['tower_ids'] = this.towerIds;
//     return data;
//   }
// }

class Staff {
  int? staffId;
  String? firstName;
  String? lastName;
  String? staffNumber;
  String? staffEmail;
  String? corporateEmail;
  String? staffPhone;
  String? staffJobPosition;
  String? company;
  int? companyId;
  String? frImageName;
  bool? enrollQR;
  bool? enrollFR;
  bool? isP1Upload;
  bool? isFrUpload;
  String? uploadReason;
  bool? isSuntecApiUpload;
  bool? consentToTC;
  String? nricNumber;
  String? cardNumber;
  String? activationDate;
  String? expirationDate;
  String? imageData;
  String? unitNO;
  String? tower;

  Staff(
      {this.staffId,
        this.firstName,
        this.lastName,
        this.staffNumber,
        this.staffEmail,
        this.corporateEmail,
        this.staffPhone,
        this.staffJobPosition,
        this.company,
        this.companyId,
        this.frImageName,
        this.enrollQR,
        this.enrollFR,
        this.isP1Upload,
        this.isFrUpload,
        this.uploadReason,
        this.isSuntecApiUpload,
        this.consentToTC,
        this.nricNumber,
        this.cardNumber,
        this.activationDate,
        this.expirationDate,
        this.imageData,
        this.unitNO,
        this.tower});

  Staff.fromJson(Map<String, dynamic> json) {
    staffId = json['staffId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    staffNumber = json['staffNumber'];
    staffEmail = json['staffEmail'];
    corporateEmail = json['corporateEmail'];
    staffPhone = json['staffPhone'];
    staffJobPosition = json['staffJobPosition'];
    company = json['company'];
    companyId = json['companyId'];
    frImageName = json['frImageName'];
    enrollQR = json['enrollQR'];
    enrollFR = json['enrollFR'];
    isP1Upload = json['isP1Upload'];
    isFrUpload = json['isFrUpload'];
    uploadReason = json['uploadReason'];
    isSuntecApiUpload = json['isSuntecApiUpload'];
    consentToTC = json['consentToTC'];
    nricNumber = json['nricNumber'];
    cardNumber = json['cardNumber'];
    activationDate = json['activationDate'];
    expirationDate = json['expirationDate'];
    imageData = json['imageData'];
    unitNO = json['unitNO'];
    tower = json['tower'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['staffId'] = this.staffId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['staffNumber'] = this.staffNumber;
    data['staffEmail'] = this.staffEmail;
    data['corporateEmail'] = this.corporateEmail;
    data['staffPhone'] = this.staffPhone;
    data['staffJobPosition'] = this.staffJobPosition;
    data['company'] = this.company;
    data['companyId'] = this.companyId;
    data['frImageName'] = this.frImageName;
    data['enrollQR'] = this.enrollQR;
    data['enrollFR'] = this.enrollFR;
    data['isP1Upload'] = this.isP1Upload;
    data['isFrUpload'] = this.isFrUpload;
    data['uploadReason'] = this.uploadReason;
    data['isSuntecApiUpload'] = this.isSuntecApiUpload;
    data['consentToTC'] = this.consentToTC;
    data['nricNumber'] = this.nricNumber;
    data['cardNumber'] = this.cardNumber;
    data['activationDate'] = this.activationDate;
    data['expirationDate'] = this.expirationDate;
    data['imageData'] = this.imageData;
    data['unitNO'] = this.unitNO;
    data['tower'] = this.tower;
    return data;
  }
}
