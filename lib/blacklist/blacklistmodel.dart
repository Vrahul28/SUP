class VisitorBlacklist {
  String? visitorBlackListId;
  String? blacklistDate;
  String? createdBy;
  String? createdOn;
  String? documentNumber;
  String? modifiedBy;
  String? modifiedOn;
  String? visitorName;

  VisitorBlacklist(
      {this.visitorBlackListId,
        this.blacklistDate,
        this.createdBy,
        this.createdOn,
        this.documentNumber,
        this.modifiedBy,
        this.modifiedOn,
        this.visitorName});

  VisitorBlacklist.fromJson(Map<String, dynamic> json) {
    visitorBlackListId = json['visitorBlackListId'];
    blacklistDate = json['blacklist_date'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    documentNumber = json['document_number'];
    modifiedBy = json['modified_by'];
    modifiedOn = json['modified_on'];
    visitorName = json['visitor_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['visitorBlackListId'] = this.visitorBlackListId;
    data['blacklist_date'] = this.blacklistDate;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['document_number'] = this.documentNumber;
    data['modified_by'] = this.modifiedBy;
    data['modified_on'] = this.modifiedOn;
    data['visitor_name'] = this.visitorName;
    return data;
  }
}