// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBPxsfxHIzUP2flClvM9T1tS2wpmGux8dE',
    appId: '1:235787761557:android:3af49756d20939aa2de89c',
    messagingSenderId: '235787761557',
    projectId: 'demo1-47460',
    storageBucket: 'demo1-47460.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBI37IzGu5J81Q4Ks5Z4eC_8SQz9zzGCAM',
    appId: '1:235787761557:ios:b8f9e2b18c564dda2de89c',
    messagingSenderId: '235787761557',
    projectId: 'demo1-47460',
    storageBucket: 'demo1-47460.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyACBF62zVdl2YmA-02VSfRXpDrGwynUZQM',
    appId: '1:235787761557:web:82c7ac3285ce2e242de89c',
    messagingSenderId: '235787761557',
    projectId: 'demo1-47460',
    authDomain: 'demo1-47460.firebaseapp.com',
    storageBucket: 'demo1-47460.appspot.com',
    measurementId: 'G-94K28HL3J8',
  );
}