class ChatRoomModel {
  String? chatroomId;
  List<String>? partycipants;

  ChatRoomModel({this.chatroomId, this.partycipants});

  ChatRoomModel.fromJson(Map<String, dynamic> json) {
    chatroomId = json['chatroomId'];
    partycipants = json['partycipants'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chatroomId'] = this.chatroomId;
    data['partycipants'] = this.partycipants;
    return data;
  }
}