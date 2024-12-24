import 'package:chat_app/model/chat_room_model.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class GetChatRoomController{
  ChatRoomModel? chatRoom;
  var uuid = Uuid();
  Future<ChatRoomModel?> getChatRoom(UserModel targetUser,UserModel userModel)
  async {
  QuerySnapshot snapshot=  await FirebaseFirestore.instance.collection('Chatroom').
    where('partycipants.${userModel.uid}',isEqualTo: true).
    where('partycipants.${targetUser.uid}',isEqualTo: true).get();

  if(snapshot.docs.length>0)
    {
      var doc=snapshot.docs[0].data();
      ChatRoomModel existChatRoom=ChatRoomModel.fromJson(doc as Map<String,dynamic>);
      chatRoom=existChatRoom;
      print('ChatRoom Already Created');
    }else
      {
       // print('ChatRoom not Created');
        ChatRoomModel chatRoomModel=
        ChatRoomModel(
          chatroomId: uuid.v4(),
          lastMessage: '',
          partycipants:{
           userModel.uid.toString():true,
           targetUser.uid.toString():true,
          } ,
        );
        await FirebaseFirestore.instance.collection('Chatroom')
            .doc(chatRoomModel.chatroomId).set(chatRoomModel.toJson());
        print(' new ChatRoom created');
        chatRoom=chatRoomModel;
      }
  print(chatRoom!.partycipants);
return chatRoom;

  }

}