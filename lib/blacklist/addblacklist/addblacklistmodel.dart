class Addbacklistmodel {
  int? visitorBlackListId;
  String? documentNumber;
  String? visitorName;
  String? blackListDate;


  Addbacklistmodel(
      {this.visitorBlackListId,
        this.documentNumber,
        this.visitorName,
        this.blackListDate,
        });

  Addbacklistmodel.fromJson(Map<String, dynamic> json) {
    visitorBlackListId = json['visitorBlackListId'];
    documentNumber = json['documentNumber'];
    visitorName = json['visitorName'];
    blackListDate = json['blackListDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['visitorBlackListId'] = this.visitorBlackListId;
    data['documentNumber'] = this.documentNumber;
    data['visitorName'] = this.visitorName;
    data['blackListDate'] = this.blackListDate;
    return data;
  }
}