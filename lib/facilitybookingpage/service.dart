class Service {
  int? id;
  String? title;
  String? name;
  String? phonenumber;
  String? emailaddress;
  String? vehiclenumber;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  // int? remind;
  String? payment;

  Service(
      {this.id,
        this.title,
        this.name,
        this.phonenumber,
        this.emailaddress,
        this.vehiclenumber,
        this.isCompleted,
        this.date,
        this.startTime,
        this.endTime,
        this.color,
        // this.remind,
        this.payment});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'name': name,
      'phonenumber' : phonenumber,
      'emailaddress' : emailaddress,
      'vehiclenumber' : vehiclenumber,
      'isCompleted': isCompleted,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'color': color,
      // 'remind': remind,
      'payment': payment,
    };
  }

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    name = json['name'];
    phonenumber = json['phonenumber'];
    emailaddress = json['emailaddress'];
    vehiclenumber = json['vehiclenumber'];
    isCompleted = json['isCompleted'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    color = json['color'];
    // remind = json['remind'];
    payment = json['payment'];
  }
}