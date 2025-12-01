class Additionalcompanydata {
  int? id;
  int? companyId;
  String? tower;
  String? floor;
  String? unitNO;
  String? area;
  String? occupancy;
  String? staffNO;

  Additionalcompanydata(
      {this.id,
        this.companyId,
        this.tower,
        this.floor,
        this.unitNO,
        this.area,
        this.occupancy,
        this.staffNO
      });


  Additionalcompanydata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['companyId'];
    tower = json['tower'];
    floor = json['floor'];
    unitNO = json['unitNO'];
    area = json['area'];
    occupancy = json['occupancy'];
    staffNO = json['staffNO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['companyId'] = this.companyId;
    data['tower'] = this.tower;
    data['floor'] = this.floor;
    data['unitNO'] = this.unitNO;
    data['area'] = this.area;
    data['occupancy'] = this.occupancy;
    data['staffNO'] = this.staffNO;
    return data;
  }


}