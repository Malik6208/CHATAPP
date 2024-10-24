
import 'package:chat_app/controller/image_upload.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:chat_app/utils/utils.dart';
import 'package:chat_app/views/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class AuthController{
static final auth=FirebaseAuth.instance;
static final fireStore=FirebaseFirestore.instance.collection('Users');
static Future<void> signUp(
    BuildContext context,
    String name,String email,String password,String cPassword,String phone)async{
   if(email=='')
     {
       Utils.showToast('Please Enter email');
     }else if(password=='')
       {
         Utils.showToast('Please Enter Password');
       }else if(password.length<=6)
       {
         Utils.showToast('Password must be grater than 6 character');
       }else if(password!=cPassword)
         {
           Utils.showToast('Password not matches');
         }else{
     try{
        await auth.createUserWithEmailAndPassword(email: email, password: password).then((value)
        async {
          if(value.user!=null)
            {
              String imgUrl=UploadImage.imgUrl;
              print('user Authenticate successfully');
              String uid=auth.currentUser!.uid;
              UserModel userModel=UserModel(fullName: name, email: email, profilePic:imgUrl , uid: uid,
                  number: phone);
              await fireStore.doc(uid).set(userModel.toJson());
              print('user data store successfully');
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
            }
        }
        ) ;


     } on FirebaseAuthException catch(ex)
  {
    Utils.showToast(ex.toString());
  }
   }
}
static login(BuildContext context,String email,String password)
async {
  if(email=='')
    {
      Utils.myFlushBar('Please Enter Email', context);
    }else if(password=='')
      {
        Utils.myFlushBar('Please Enter Password', context);
      }else{
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password).then((val){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
      });
    }on FirebaseAuthException catch(ex)
    {
      Utils.snackBar(context, ex.toString());
    }
  {

  }
  }
}


}
