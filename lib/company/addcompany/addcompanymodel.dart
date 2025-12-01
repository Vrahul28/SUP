class Addcompanymodel {
  int? companyId;
  String? companyName;
  String? displayName;
  String? UAG;
  String? contactName;
  String? contactNO;
  String? tower;
  String? unitNO;


  Addcompanymodel(
      {this.companyId,
        this.companyName,
        this.displayName,
        this.UAG,
        this.contactName,
        this.contactNO,
        this.tower,
        this.unitNO,
      });


  Addcompanymodel.fromJson(Map<String, dynamic> json) {
    companyId = json['companyId'];
    companyName = json['companyName'];
    displayName = json['displayName'];
    UAG = json['UAG'];
    contactName = json['contactName'];
    contactNO = json['contactNO'];
    tower = json['tower'];
    unitNO = json['unitNO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyId'] = this.companyId;
    data['companyName'] = this.companyName;
    data['displayName'] = this.displayName;
    data['UAG'] = this.UAG;
    data['contactName'] = this.contactName;
    data['contactNO'] = this.contactNO;
    data['tower'] = this.tower;
    data['unitNO'] = this.unitNO;
    return data;
  }


}