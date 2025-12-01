class Response {
  String? message;
  String? messageType;

  Response({this.message, this.messageType});

  Response.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    messageType = json['message_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['message_type'] = this.messageType;
    return data;
  }
}