import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:instagrammm/utilities/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';



class StorageService {
  static Future<String> uploadUserProfileImage(String url, File imageFile) async {
    String photoId = Uuid().v4();
    File image = await compressImage(photoId, imageFile);

    if(url.isNotEmpty){
      //updating user profile image
      RegExp exp = RegExp(r'userProfile_(.*).jpg');
      photoId = exp.firstMatch(url)[1];
    }

    StorageUploadTask uploadTask = storageRef
      .child('images/users/userProfile_$photoId.jpg')
      .putFile(image);
    StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
    String downloadUrl = await storageSnap.ref.getDownloadURL();
    return downloadUrl;

  }

  //compressing the image uploaded
  static Future<File> compressImage(String photoId, File image) async {
    final tempDir = await getTemporaryDirectory();//getting a temporary directory
    final path = tempDir.path;

    File compressImageFile = await FlutterImageCompress.compressAndGetFile(
        image.absolute.path,
        '$path/img_$photoId.jpg',
        quality: 70,
    );
    return compressImageFile;
  }
}