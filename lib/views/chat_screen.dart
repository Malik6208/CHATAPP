import 'dart:math';

import 'package:chat_app/controller/callin_page/audio_call.dart';
import 'package:chat_app/controller/callin_page/video_calling.dart';
import 'package:chat_app/controller/firebase/firebaseHelper.dart';
import 'package:chat_app/model/chat_room_model.dart';
import 'package:chat_app/model/message_model/message_model.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
class ChatScreen extends StatefulWidget {

  final UserModel userModel;
  final UserModel targetUser;
  final ChatRoomModel chatRoomModel;
  final User firebaseUser;
   ChatScreen({
     super.key,
     required this.userModel,
     required this.targetUser,
     required this.chatRoomModel,
     required this.firebaseUser
   });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  FirebaseHelper firebaseHelper=FirebaseHelper();
  TextEditingController messageController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        backgroundColor: Colors.blue,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(widget.targetUser.profilePic.toString()),
            ),SizedBox(width: 10,),
            Text(
                widget.targetUser.fullName.toString(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(onPressed: (){
             Get.to( VideoCalling(
               userId: widget.targetUser.uid!,
               userName: widget.targetUser.fullName!,
               callId: widget.chatRoomModel.chatroomId!,
             ));
            }, icon: Icon(Icons.videocam,size: 30,)),
            IconButton(onPressed: (){
              Get.to( VoiceCall(
                userId: widget.targetUser.uid!,
                userName: widget.targetUser.fullName!,
                callId: widget.chatRoomModel.chatroomId!,
              ));
            }, icon: Icon(Icons.call,size: 30,))
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: Container(
                  child:  StreamBuilder<List<MessageModel>>(
                    stream: firebaseHelper.fetchAllMessage(widget.chatRoomModel), // Call your Firestore query here
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        print(snapshot.error);
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No users found.'));
                      }

                      final messages = snapshot.data!;

                      return ListView.builder(
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          print('Uouyt $message' );
                          return Row(
                            mainAxisAlignment: message.sender==widget.userModel.uid?
                            MainAxisAlignment.end:MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 4,horizontal: 15),
                                padding:EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                                decoration: BoxDecoration(
                                  color: message.sender==widget.userModel.uid?Colors.greenAccent:Colors.white,
                                  borderRadius: BorderRadius.circular(10)
                                ),




                                child: Text(message.message.toString(),style: TextStyle(fontSize: 18),),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                )),


            Container(
              height: 65,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                borderRadius: BorderRadius.circular(25)
              ),
                padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6
              ),
              child: Row(
                children: [
                  Flexible(
                      child: TextField(
                        controller:messageController ,
                        maxLines: null,
                        decoration: InputDecoration(

                          border: InputBorder.none,
                          hintText: 'Enter Message',

                        ),
                      )
                  ),
                  IconButton(onPressed: (){
                    sendMessage(
                        messageController.text.trim());
                    messageController.clear();
                  },
                      icon: Icon(Icons.send,color: Colors.blue,size: 35,))
                ],
              ),

            )
          ],
        ),
      ),
    );
  }
  void sendMessage(String msg,){
    var uuid=Uuid();
    if(msg!='')
      {
        MessageModel messageModel=
        MessageModel(
          messageId: uuid.v4().toString(),
          createdOn: DateTime.now().toString(),
          message: msg,
          seen: false,
          sender:widget.userModel.uid,
        );
        FirebaseFirestore.instance.collection('Chatroom').
        doc(widget.chatRoomModel.chatroomId).collection('messages').
        doc(messageModel.messageId).set(messageModel.toJson());
        print('message send');

        widget.chatRoomModel.lastMessage=msg;
        FirebaseFirestore.instance.collection('Chatroom').
        doc(widget.chatRoomModel.chatroomId).set(widget.chatRoomModel.toJson());
      }

  }
}
