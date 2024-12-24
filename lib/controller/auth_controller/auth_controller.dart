
import 'dart:io';

import 'package:chat_app/controller/pick_image.dart';
import 'package:chat_app/controller/upload_image.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:chat_app/utils/utils.dart';
import 'package:chat_app/views/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
class AuthController{
 final auth=FirebaseAuth.instance;
 final fireStore=FirebaseFirestore.instance.collection('Users');
 PickImageController imageController=Get.put(PickImageController());
 UploadImage uploadImage=UploadImage();
 Future<void> signUp(
    BuildContext context,
    String name,String email,String password,String phone)async{
   if(email=='')
     {
       Utils.showToast('Please Enter email');
     }else if(password=='')
       {
         Utils.showToast('Please Enter Password');
       }else if(imageController.imageUrl==''){
     Utils.showToast('Please select image');
   }
   else if(password.length<=6)
       {
         Utils.showToast('Password must be grater than 6 character');
       }else{
     try{
       EasyLoading.show(status: 'Please wait...');
       File image=File(imageController.imageUrl.toString());
       String? imgUrl=await uploadImage.uploadImageToFirebase(image);
        await auth.createUserWithEmailAndPassword(email: email, password: password).then((value)
        async {
          if(value.user!=null)
            {

              print('user Authenticate successfully');
              String uid=auth.currentUser!.uid;
              UserModel userModel=UserModel(
                  fullName: name,
                  email: email,
                  profilePic:imgUrl , uid: uid,
                  number: phone);
              await fireStore.doc(uid).set(userModel.toJson());
              print('user data store successfully');
              EasyLoading.dismiss();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
            }
        }
        ) ;


     } on FirebaseAuthException catch(ex)
  {
    EasyLoading.dismiss();
    Utils.showToast(ex.toString());
  }
   }
}
 login(BuildContext context,String email,String password)
async {
  if(email=='')
    {
      Utils.myFlushBar('Please Enter Email', context);
    }else if(password=='')
      {
        Utils.myFlushBar('Please Enter Password', context);
      }else{
    try {
      EasyLoading.show(status: 'Please Wait...');
      await auth.signInWithEmailAndPassword(email: email, password: password).then((val){
        EasyLoading.dismiss();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
      });
    }on FirebaseAuthException catch(ex)
    {
      EasyLoading.dismiss();
      Get.snackbar('Error', ex.toString());
    }
  {

  }
  }
}


}
