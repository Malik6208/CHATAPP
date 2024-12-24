import 'package:chat_app/controller/firebase/firebaseHelper.dart';
import 'package:chat_app/controller/get_chat_room_controller.dart';
import 'package:chat_app/model/chat_room_model.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:chat_app/utils/utils.dart';
import 'package:chat_app/views/all_users.dart';
import 'package:chat_app/views/chat_screen.dart';
import 'package:chat_app/views/login_screen.dart';
import 'package:chat_app/views/my_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ChatRoomModel chatRoomModel;
  GetChatRoomController chatRoomController=GetChatRoomController();
  var searchController=TextEditingController();
  final fireBaseUser=FirebaseAuth.instance.currentUser;
  late final UserModel userModel;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('HomeScreen'),

        centerTitle: true,
          backgroundColor: Colors.blue,
      ),
      drawer: myDrawer(context),
      body: SingleChildScrollView(
        child: Column(
        
          children: [
           Padding(
             padding: const EdgeInsets.all(12.0),
             child: TextField(
        
               controller: searchController,
               decoration: InputDecoration(
                 hintText: 'Search...',
                 suffixIcon: Icon(Icons.search,size: 33,color: Colors.blue,),
                 focusedBorder: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(16),
                     borderSide: BorderSide(
                         color: Colors.blue,
                         width: 2
                     )
                 ),
                 enabledBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(16),
                   borderSide: BorderSide(
                     color: Colors.blue,
                     width: 2
                   )
                 )
               ),
             ),
           ),
            FutureBuilder<List<UserModel>>(
              future:FirebaseHelper.fetchAllUsers(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting)
                {
                  return Center(child: CircularProgressIndicator());
                }else if(!snapshot.hasData)
                {
                  return Text('No any Users');
                }else
                {
                  final users = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user=users[index];
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 9, 2, 8),
                        child: ListTile(
                          onTap: () async {
                        ChatRoomModel? chatRoom=  await chatRoomController.
                        getChatRoom(user, userModel);
                        chatRoomModel=chatRoom!;
                        if(chatRoom!=null)
                          {

                            Navigator.push(context, MaterialPageRoute(builder:
                                (context) => ChatScreen(
                              firebaseUser: fireBaseUser!,
                              userModel: userModel,
                              targetUser:user ,
                              chatRoomModel:chatRoom! ,
                            ),));

                          }
                          },
                          leading: CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(user.profilePic.toString()),
                          ),
                          title: Text(user.fullName.toString()),
                        ),
                      );
                    },);
                }
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
          onPressed: ()async{

          /*//Get.to(AllUsers(chatRoomModel: chatRoomModel, userModel: userModel));
            Navigator.push(context,
                MaterialPageRoute(builder: (context) {
                  return AllUsers(chatRoomModel: chatRoomModel, userModel: userModel);
                },));*/
          },
        child: Icon(Icons.add),
      ),
    );
    
  }

  void getUserInfo()async {
    final userId=FirebaseAuth.instance.currentUser!.uid;
  userModel =(await  FirebaseHelper.fetchUserInfo(userId))!;
  print('Fuck Name: ${userModel.fullName}');
  }


}
