import 'package:chat_app/controller/cheack_user.dart';
import 'package:chat_app/views/home_screen.dart';
import 'package:chat_app/views/login_screen.dart';
import 'package:chat_app/views/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
        appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.blue,
        titleTextStyle: TextStyle(fontSize: 40,color: Colors.white,fontWeight: FontWeight.w700),
        ),
          textTheme: TextTheme(

          )
      ),
      home: const CheackUser(),
    );
  }
}
