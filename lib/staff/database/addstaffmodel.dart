

class Addstaffmodel {
  int? staffId;
  String? firstName;
  String? lastName;
  String? nricNumber;
  String? corporateEmail;
  String? staffPhone;
  String? staffJobPosition;
  String? tower;
  String? company;
  String? unitNO;
  String? cardNO;
  String? activationDate;
  String? profileImage;
  String? qrcode;
  String? enableFR;

  Addstaffmodel(
      {this.staffId,
        this.firstName,
        this.lastName,
        this.nricNumber,
        this.corporateEmail,
        this.staffPhone,
        this.staffJobPosition,
        this.tower,
        this.company,
        this.unitNO,
        this.cardNO,
        this.activationDate,
        this.profileImage,
        this.qrcode,
        this.enableFR
      });


  Addstaffmodel.fromJson(Map<String, dynamic> json) {
    staffId = json['staffId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    nricNumber = json['nricNumber'];
    corporateEmail = json['corporateEmail'];
    staffPhone = json['staffPhone'];
    staffJobPosition = json['staffJobPosition'];
    tower = json['tower'];
    company = json['company'];
    unitNO = json['unitNO'];
    cardNO = json['cardNO'];
    activationDate = json['activationDate'];
    profileImage = json['profileImage'];
    qrcode = json['qrcode'];
    enableFR = json['enableFR'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['staffId'] = this.staffId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['nricNumber'] = this.nricNumber;
    data['corporateEmail'] = this.corporateEmail;
    data['staffPhone'] = this.staffPhone;
    data['staffJobPosition'] = this.staffJobPosition;
    data['tower'] = this.tower;
    data['company'] = this.company;
    data['unitNO'] = this.unitNO;
    data['cardNO'] = this.cardNO;
    data['activationDate'] = this.activationDate;
    data['profileImage'] = this.profileImage;
    data['qrcode'] = this.qrcode;
    data['enableFR'] = this.enableFR;
    return data;
  }
}