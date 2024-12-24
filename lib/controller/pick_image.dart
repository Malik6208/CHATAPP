import 'dart:io';

import 'package:chat_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class PickImageController extends GetxController{
  FirebaseStorage storage = FirebaseStorage.instance;
 //static late String dawnlodUrl;

 RxString imageUrl=''.obs;
  final ImagePicker _picker = ImagePicker();
   Future selctImage(ImageSource source)async{
    XFile? image=await _picker.pickImage(
        source: source);
    if(image!=null)

      {
        cropeImage(image.path.toString() );
      }

  }
  Future cropeImage(String image) async{
   CroppedFile? croppedFile=   await ImageCropper().cropImage(
         sourcePath: image,
       compressQuality: 50,
       aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1)
     );
   if(croppedFile!=null)
   {
    imageUrl.value=croppedFile.path.toString();
     print('File picked sucsesfully');


   }
 }

}