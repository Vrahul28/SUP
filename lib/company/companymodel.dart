class Company {
  int? companyID;
  String? company;
  String? contactPerson;
  String? contactNo;
  String? uAG;
  String? kioskDisplayName;
  String? createdBy;
  String? createdOn;
  String? modifiedBy;
  String? modifiedOn;
  String? companySR;
  String? companySP;
  String? companyVendor;
  String? showVMS;
  String? uAGS;
  String? towers;
  String? unitsNo;
  String? areas;
  String? occupanys;
  String? noOfStaff;
  String? towerString;
  String? unitNoString;
  String? units;

  Company(
      {this.companyID,
        this.company,
        this.contactPerson,
        this.contactNo,
        this.uAG,
        this.kioskDisplayName,
        this.createdBy,
        this.createdOn,
        this.modifiedBy,
        this.modifiedOn,
        this.companySR,
        this.companySP,
        this.companyVendor,
        this.showVMS,
        this.uAGS,
        this.towers,
        this.unitsNo,
        this.areas,
        this.occupanys,
        this.noOfStaff,
        this.towerString,
        this.unitNoString,
        this.units});

  Company.fromJson(Map<String, dynamic> json) {
    companyID = json['companyID'];
    company = json['company'];
    contactPerson = json['contactPerson'];
    contactNo = json['contactNo'];
    uAG = json['uAG'];
    kioskDisplayName = json['kioskDisplayName'];
    createdBy = json['createdBy'];
    createdOn = json['createdOn'];
    modifiedBy = json['modifiedBy'];
    modifiedOn = json['modifiedOn'];
    companySR = json['companySR'];
    companySP = json['companySP'];
    companyVendor = json['companyVendor'];
    showVMS = json['showVMS'];
    uAGS = json['uAGS'];
    towers = json['towers'];
    unitsNo = json['unitsNo'];
    areas = json['areas'];
    occupanys = json['occupanys'];
    noOfStaff = json['noOfStaff'];
    towerString = json['towerString'];
    unitNoString = json['unitNoString'];
    units = json['units'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyID'] = this.companyID;
    data['company'] = this.company;
    data['contactPerson'] = this.contactPerson;
    data['contactNo'] = this.contactNo;
    data['uAG'] = this.uAG;
    data['kioskDisplayName'] = this.kioskDisplayName;
    data['createdBy'] = this.createdBy;
    data['createdOn'] = this.createdOn;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedOn'] = this.modifiedOn;
    data['companySR'] = this.companySR;
    data['companySP'] = this.companySP;
    data['companyVendor'] = this.companyVendor;
    data['showVMS'] = this.showVMS;
    data['uAGS'] = this.uAGS;
    data['towers'] = this.towers;
    data['unitsNo'] = this.unitsNo;
    data['areas'] = this.areas;
    data['occupanys'] = this.occupanys;
    data['noOfStaff'] = this.noOfStaff;
    data['towerString'] = this.towerString;
    data['unitNoString'] = this.unitNoString;
    data['units'] = this.units;
    return data;
  }
}


class CompanyTowerList {
  int? id;
  int? companyID;
  int? towerID;
  int? floorID;
  String? unitNo;
  String? area;
  String? occupancy;
  String? noOfStaff;
  String? companyName;

  CompanyTowerList({
    this.id,
    this.companyID,
    this.towerID,
    this.floorID,
    this.unitNo,
    this.area,
    this.occupancy,
    this.noOfStaff,
    this.companyName,
  });

  factory CompanyTowerList.fromJson(Map<String, dynamic> json) {
    return CompanyTowerList(
      id: json['iD'],
      companyID: json['companyID'],
      towerID: json['towerID'],
      floorID: json['floorID'],
      unitNo: json['unitNo'],
      area: json['area'],
      occupancy: json['occupancy'],
      noOfStaff: json['noOfStaff'],
      companyName: json['companyName'],
    );
  }
}
