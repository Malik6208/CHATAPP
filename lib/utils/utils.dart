import 'package:another_flushbar/flushbar.dart';
import 'package:chat_app/controller/pick_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../views/login_screen.dart';

class Utils{
  PickImageController imageController=Get.put(PickImageController());
  static fieldFocusChange(BuildContext context,FocusNode current,FocusNode next)
  {
    FocusScope.of(context).requestFocus(next);
  }

  static myFlushBar(String message,BuildContext context)
  {
    return Flushbar(
      title: "Shoyeb Malik",
      titleColor: Colors.white,
      message: message,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticOut,
      backgroundColor: Colors.red,
      boxShadows: [BoxShadow(color: Colors.blue, offset: Offset(0.0, 2.0), blurRadius: 3.0)],
      backgroundGradient: LinearGradient(colors: [Colors.blueGrey, Colors.black]),
      isDismissible: false,
      duration: Duration(seconds: 4),
      icon: Icon(
        Icons.error,
        color: Colors.greenAccent,size: 26,
      ),
      borderRadius: BorderRadius.circular(21),
      //showProgressIndicator: true,
      /* progressIndicatorBackgroundColor: Colors.blueGrey,
     titleText: Text(
       "Hello Hero",
       style: TextStyle(
           fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.yellow[600], fontFamily: "ShadowsIntoLightTwo"),
     ),
     messageText: Text(
       "You killed that giant monster in the city. Congratulations!",
       style: TextStyle(fontSize: 18.0, color: Colors.green, fontFamily: "ShadowsIntoLightTwo"),
     ),*/
    )..show(context);
  }
static showToast(String msg)
{
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );
}

   snackBar(BuildContext context,String message){
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  }
  static loading()
  {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
   showDailog(BuildContext context)
  {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Uoload Image'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: (){
                    Navigator.pop(context);
                    imageController.selctImage(ImageSource.gallery);
                  },
                  leading: Icon(Icons.photo_album),
                  title: Text('Slect Image from gallery'),
                ),
                ListTile(
                  onTap: (){
                  Navigator.pop(context);
                  imageController.selctImage(ImageSource.camera);
                  },
                  leading: Icon(Icons.camera_alt),
                  title: Text('Slect Image from gallery'),
                )
              ],
            ),
          );
        },);
  }
  static logoutDialog(BuildContext context)
  {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Are you sure to logout'),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text('Cencel')),
              TextButton(onPressed: (){
                FirebaseAuth.instance.signOut().then((val){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                });
              }, child: Text('Ok')),
            ],

          );
        },);

  }
}