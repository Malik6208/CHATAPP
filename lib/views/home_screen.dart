import 'package:chat_app/controller/firebase/firebaseHelper.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:chat_app/utils/utils.dart';
import 'package:chat_app/views/chat_screen.dart';
import 'package:chat_app/views/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var searchController=TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('HomeScreen'),

        centerTitle: true,
          backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            FutureBuilder(
                future: FirebaseHelper.getUserProfile(),
                builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return Center(child: CircularProgressIndicator());
    } else if (snapshot.hasData) {
      // Access the profile data
      Map<String, dynamic> profileData = snapshot.data as Map<String, dynamic>;
      return UserAccountsDrawerHeader(

        accountName: Text(profileData['fullName'].toString()),
        accountEmail: Text(profileData['email'].toString()),
        currentAccountPicture: CircleAvatar(
          backgroundImage: NetworkImage(profileData['profilePic'].toString()),
        ),
      );
    } else{
      return Text('No Data Found');
    }
    },
            ),
            ElevatedButton(onPressed: (){
              Utils.logoutDialog(context);
            },
                child: Text('Logout',style: TextStyle(color: Colors.white,fontSize: 19),),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple
            ),
            )
          ],
        ),
      ),
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
            StreamBuilder(
                stream: FirebaseFirestore.instance.collection('Users').snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting)
                    {
                      return Center(child: CircularProgressIndicator());
                    }else if(!snapshot.hasData)
                      {
                        return Text('No any Users');
                      }else
                        {
                          final docs = snapshot.data!.docs;
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: docs.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 9, 2, 8),
                                  child: ListTile(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(),));
                                    },
                                    leading: CircleAvatar(
                                      radius: 40,
                                      backgroundImage: NetworkImage(docs[index]['profilePic'].toString()),
                                    ),
                                    title: Text(docs[index]['fullName'].toString()),
                                  ),
                                );
                              },);
                        }
                },
            )
          ],
        ),
      ),
    );
  }


}
