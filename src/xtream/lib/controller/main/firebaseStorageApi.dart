
import 'dart:io' as io;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xtream/model/user.dart';

class FirebaseStorageApi {

  static const String _defaultPath = 'gs://xtream-7cb96.appspot.com/';


  static Future<String> uploadFile(XFile? file, String path, User user) async {
      if (file == null) return '';

      Reference ref = FirebaseStorage.instance.ref(_defaultPath)
          .child(path)
          .child(user.uid);

      final metadata = SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {'picked-file-path': file.path});

      if (kIsWeb) {
        await ref.putData(await file.readAsBytes(), metadata);
      } else {
        await ref.putFile(io.File(file.path), metadata);
      }
      return getUserProfileImageUrl(user);
  }

  static Future<String> getUserProfileImageUrl(User user) async {
    Reference ref = FirebaseStorage.instance.ref(_defaultPath)
        .child('images/profile')
        .child(user.uid);
    return await ref.getDownloadURL();

  }



}