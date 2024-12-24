import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../controller/firebase/firebaseHelper.dart';
import '../utils/utils.dart';

Widget myDrawer(BuildContext context){
  final uId=FirebaseAuth.instance.currentUser!.uid;
  return Drawer(
    child: ListView(
      children: [
        FutureBuilder(
          future: FirebaseHelper.fetchUserInfo(uId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              // Access the profile data
              final user = snapshot.data!;
              return UserAccountsDrawerHeader(

                accountName: Text(user.fullName.toString()),
                accountEmail: Text(user.email.toString()),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(user.profilePic.toString()),
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
  );
}