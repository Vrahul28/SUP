class Company {
  String? companyId;
  String? companyName;
  String? companySp;
  String? companySr;
  String? companyVendor;
  String? contactNo;
  String? contactPerson;
  String? kioskDisplayName;
  String? showVms;
  String? uag;
  String? companyTowerId;
  String? area;
  String? floorId;
  String? noOfStaff;
  String? occupancy;
  String? towerId;
  String? towerIds;
  String? unitNo;
  String? unitNos;

  Company(
      {this.companyId,
        this.companyName,
        this.companySp,
        this.companySr,
        this.companyVendor,
        this.contactNo,
        this.contactPerson,
        this.kioskDisplayName,
        this.showVms,
        this.uag,
        this.companyTowerId,
        this.area,
        this.floorId,
        this.noOfStaff,
        this.occupancy,
        this.towerId,
        this.towerIds,
        this.unitNo,
        this.unitNos});

  Company.fromJson(Map<String, dynamic> json) {
    companyId = json['company_id'];
    companyName = json['company_name'];
    companySp = json['company_sp'];
    companySr = json['company_sr'];
    companyVendor = json['company_vendor'];
    contactNo = json['contact_no'];
    contactPerson = json['contact_person'];
    kioskDisplayName = json['kiosk_display_name'];
    showVms = json['show_vms'];
    uag = json['uag'];
    companyTowerId = json['company_tower_id'];
    area = json['area'];
    floorId = json['floor_id'];
    noOfStaff = json['no_of_staff'];
    occupancy = json['occupancy'];
    towerId = json['tower_id'];
    towerIds= json['tower_ids'];
    unitNo = json['unit_no'];
    unitNos = json['unit_nos'];
  }

  get occupancies => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['company_id'] = this.companyId;
    data['company_name'] = this.companyName;
    data['company_sp'] = this.companySp;
    data['company_sr'] = this.companySr;
    data['company_vendor'] = this.companyVendor;
    data['contact_no'] = this.contactNo;
    data['contact_person'] = this.contactPerson;
    data['kiosk_display_name'] = this.kioskDisplayName;
    data['show_vms'] = this.showVms;
    data['uag'] = this.uag;
    data['company_tower_id'] = this.companyTowerId;
    data['area'] = this.area;
    data['floor_id'] = this.floorId;
    data['no_of_staff'] = this.noOfStaff;
    data['occupancy'] = this.occupancy;
    data['tower_id'] = this.towerId;
    data['tower_ids'] = this.towerIds;
    data['unit_no'] = this.unitNo;
    data['unit_nos'] = this.unitNos;
    return data;
  }
}