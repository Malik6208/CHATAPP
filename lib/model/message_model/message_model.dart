class MessageModel {
  String? sender;
  String? message;
  bool? seen;
  DateTime? createdOn;

  MessageModel({this.sender, this.message, this.seen, this.createdOn});

  MessageModel.fromJson(Map<String, dynamic> json) {
    sender = json['sender'];
    message = json['message'];
    seen = json['seen'];
    createdOn = json['createdOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sender'] = this.sender;
    data['message'] = this.message;
    data['seen'] = this.seen;
    data['createdOn'] = this.createdOn;
    return data;
  }
}