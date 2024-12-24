import 'package:chat_app/controller/firebase/firebaseHelper.dart';
import 'package:chat_app/model/chat_room_model.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class AllUsers extends StatefulWidget {
 final ChatRoomModel chatRoomModel;
 final UserModel userModel;
   AllUsers({super.key,required this.chatRoomModel,required this.userModel});

  @override
  State<AllUsers> createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All users'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Chatroom').
          where('partycipants',isNotEqualTo: true).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData ) {
              return const Center(child: Text('No users found.'));
            }else{
              QuerySnapshot chatroomSnapshot=snapshot.data as QuerySnapshot<Object?>;
              return ListView.builder(
                itemCount: chatroomSnapshot.docs.length,
                  itemBuilder: (context, index) {
                    ChatRoomModel chatRoomModel =
                    ChatRoomModel.fromJson(chatroomSnapshot.
                    docs[index].data()as Map<String,dynamic>);
                    Map<String,dynamic> participents=chatRoomModel.partycipants!;
                    List<String> paricipantsKey=participents.keys.toList();
                    paricipantsKey.remove(widget.userModel.uid);
                    return FutureBuilder(
                        future: FirebaseHelper.fetchUserInfo(paricipantsKey[0]),
                        builder: (context, snapshot) {
                         if (snapshot.connectionState == ConnectionState.waiting) {
                         return const Center(child: CircularProgressIndicator());
                         }
                          if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                           }
                           if (!snapshot.hasData ) {
                            return const Center(child: Text('No users found.'));
                             }else {
                             UserModel targetUser = snapshot.data as UserModel;
                             return ListTile(
                                leading: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                    targetUser.profilePic.toString()
                                  ),
                                ),
                               title: Text(targetUser.fullName.toString(),
                                 style:const TextStyle(fontSize: 20),),
                               subtitle: Text(chatRoomModel.lastMessage.toString(),
                                 style:const TextStyle(fontSize: 15),
                               ),
                             );
                           }
                        },
                    );
                  },);
            }
          },
      ),
    );
  }
}
