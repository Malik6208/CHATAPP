import 'package:chat_app/views/home_screen.dart';
import 'package:chat_app/views/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class CheackUser extends StatelessWidget {
  const CheackUser({super.key});

  @override
  Widget build(BuildContext context) {
    return checkuser();
  }
  checkuser() {
    final auth=FirebaseAuth.instance.currentUser;
    if(auth!=null)
    {
      return HomeScreen();
    }else{
      return LoginScreen();
    }
  }
}


