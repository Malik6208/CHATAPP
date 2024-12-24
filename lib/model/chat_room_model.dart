class ChatRoomModel {
  String? chatroomId;
  Map<String, dynamic>? partycipants;
  String? lastMessage;

  ChatRoomModel({this.chatroomId, this.partycipants,this.lastMessage});

  ChatRoomModel.fromJson(Map<String, dynamic> json) {
    chatroomId = json['chatroomId'];
    partycipants = json['partycipants'];
    lastMessage = json['lastMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chatroomId'] = this.chatroomId;
    data['partycipants'] = this.partycipants;
    data['lastMessage'] = this.lastMessage;
    return data;
  }
}