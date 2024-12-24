import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? messageId;
  String? sender;
  String? message;
  bool? seen;
  String? createdOn;

  MessageModel({this.sender, this.message, this.seen, this.createdOn,required this.messageId});

  MessageModel.fromJson(Map<String, dynamic> json) {
    sender = json['sender'];
    message = json['message'];
    seen = json['seen'];
    createdOn = json['createdOn'];
    messageId = json['messageId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sender'] = this.sender;
    data['message'] = this.message;
    data['seen'] = this.seen;
    data['createdOn'] = this.createdOn;
    data['messageId'] = this.messageId;
    return data;
  }
}