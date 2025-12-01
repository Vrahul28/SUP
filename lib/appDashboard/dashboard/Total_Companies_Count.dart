class TotalCount {
  String? total;
  String? tower1;
  String? tower2;
  String? tower3;
  String? tower4;
  String? tower5;

  TotalCount(
      {this.total,
        this.tower1,
        this.tower2,
        this.tower3,
        this.tower4,
        this.tower5});

  TotalCount.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    tower1 = json['tower_1'];
    tower2 = json['tower_2'];
    tower3 = json['tower_3'];
    tower4 = json['tower_4'];
    tower5 = json['tower_5'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['tower_1'] = this.tower1;
    data['tower_2'] = this.tower2;
    data['tower_3'] = this.tower3;
    data['tower_4'] = this.tower4;
    data['tower_5'] = this.tower5;
    return data;
  }
}

