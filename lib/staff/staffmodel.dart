class Staff {
  String? staffId;
  String? activationDate;
  String? company;
  String? expirationDate;
  String? firstName;
  String? lastName;
  String? companyId;
  String? cardNumber;
  String? imageData;
  String? towerIds;

  Staff(
      {this.staffId,
        this.activationDate,
        this.company,
        this.expirationDate,
        this.firstName,
        this.lastName,
        this.companyId,
        this.cardNumber,
        this.imageData,
        this.towerIds});

  Staff.fromJson(Map<String, dynamic> json) {
    staffId = json['staff_id'];
    activationDate = json['activation_date'];
    company = json['company'];
    expirationDate = json['expiration_date'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    companyId = json['company_id'];
    cardNumber = json['card_number'];
    imageData = json['image_data'];
    towerIds = json['tower_ids'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['staff_id'] = this.staffId;
    data['activation_date'] = this.activationDate;
    data['company'] = this.company;
    data['expiration_date'] = this.expirationDate;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['company_id'] = this.companyId;
    data['card_number'] = this.cardNumber;
    data['image_data'] = this.imageData;
    data['tower_ids'] = this.towerIds;
    return data;
  }
}