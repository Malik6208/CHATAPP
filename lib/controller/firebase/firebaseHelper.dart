import 'package:chat_app/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class FirebaseHelper{
 static UserModel? userModel;

 static Future getUserProfile() async {
   User? user=FirebaseAuth.instance.currentUser;
   if (user != null) {
     DocumentSnapshot userProfile =
     await FirebaseFirestore.instance.collection('Users').doc(user!.uid).get();
     return userProfile.data() as Map<String, dynamic>?;
   }else{
     Text('No user Sign in');
     return null;
   }
  }

  }
