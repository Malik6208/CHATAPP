import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
class UploadImage{


  Future<String?> uploadImageToFirebase(File image) async {
    try {
      // Create a reference in Firebase Storage
      String fileName = 'Shoyeb/${DateTime.now().millisecondsSinceEpoch}.jpg';
      Reference storageRef = FirebaseStorage.instance.ref().child(fileName);

      // Upload the image file
      UploadTask uploadTask = storageRef.putFile(image);
      TaskSnapshot snapshot = await uploadTask;

      // Get the download URL
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      EasyLoading.dismiss();
      print('Error uploading image: $e');
      return null;
    }
  }
}