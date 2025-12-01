class Floor {
  String? floorId;
  String? createdBy;
  String? createdOn;
  String? floor;
  String? floorName;
  String? modifiedBy;
  String? modifiedOn;
  String? tower;

  Floor(
      {this.floorId,
        this.createdBy,
        this.createdOn,
        this.floor,
        this.floorName,
        this.modifiedBy,
        this.modifiedOn,
        this.tower});

  Floor.fromJson(Map<String, dynamic> json) {
    floorId = json['floor_id'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    floor = json['floor'];
    floorName = json['floor_name'];
    modifiedBy = json['modified_by'];
    modifiedOn = json['modified_on'];
    tower = json['tower'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['floor_id'] = this.floorId;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['floor'] = this.floor;
    data['floor_name'] = this.floorName;
    data['modified_by'] = this.modifiedBy;
    data['modified_on'] = this.modifiedOn;
    data['tower'] = this.tower;
    return data;
  }
}