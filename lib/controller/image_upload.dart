import 'dart:io';

import 'package:chat_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage{
 static FirebaseStorage storage = FirebaseStorage.instance;
 static late String dawnlodUrl;
 static File? _image;
 static final ImagePicker _picker = ImagePicker();
  static Future selctImage(ImageSource source)async{
    XFile? image=await _picker.pickImage(
        source: source);
    if(image!=null)

      {
        cropeImage(image );
      }

  }
 static Future cropeImage(XFile image) async{
   CroppedFile? croppedFile=   await ImageCropper().cropImage(
         sourcePath: image.path,
       compressQuality: 50,
       aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1)
     );
   if(croppedFile!=null)
   {
     _image=File(croppedFile.path);
     print('File picked sucsesfully');
     print(_image!.path);
     _uploadImage();
   }
 }
 static Future<String> _uploadImage() async {
    try{
      String id=DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = storage.ref().child('uploads/$id');
      UploadTask uploadTask = ref.putFile(_image!);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      dawnlodUrl=await taskSnapshot.ref.getDownloadURL();
      print('File uploaded successfully! URL: $dawnlodUrl');
    }
    on FirebaseAuthException catch(e)
   {
     Utils.showToast(e.toString());
   }
    return dawnlodUrl;
  }
static File? get getFile=> _image;
  static String get imgUrl=>dawnlodUrl;
}