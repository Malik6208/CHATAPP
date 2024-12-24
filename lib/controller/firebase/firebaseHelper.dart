import 'package:chat_app/model/chat_room_model.dart';
import 'package:chat_app/model/message_model/message_model.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class FirebaseHelper{
 static UserModel? userModel;

static final userId=FirebaseAuth.instance.currentUser!.uid;

static Future<UserModel?> fetchUserInfo(String userId ) async {
   try {
     final doc = await FirebaseFirestore.instance.collection('Users').doc(userId).get();
     if (doc.exists) {
       return UserModel.fromJson( doc.data()!);
     }
     return null; // User not found
   } catch (e) {
     print('Error fetching user: $e');
     return null;
   }
 }

 static Future<List<UserModel>> fetchAllUsers() async {
   try {
     final querySnapshot = await FirebaseFirestore.instance.
     collection('Users').where('uid',isNotEqualTo:userId ).get();
     return querySnapshot.docs
         .map((doc) => UserModel.fromJson(doc.data()))
         .toList();
   } catch (e) {
     print('Error fetching users: $e');
     return [];
   }
 }
 Stream<List<MessageModel>> fetchAllMessage(ChatRoomModel chatRoomModel) {
   return FirebaseFirestore.instance.collection('Chatroom').
   doc(chatRoomModel.chatroomId).collection('messages').orderBy('createdOn',descending: true). // Replace 'users' with your collection name
       snapshots()
       .map((snapshot) => snapshot.docs.map((doc) {
         print('ddd ${doc.data()}');
     return MessageModel.fromJson(doc.data(), );
   }).toList());
 }

}
