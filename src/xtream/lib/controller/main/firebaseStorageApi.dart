
import 'dart:io' as io;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xtream/model/user.dart';

class FirebaseStorageApi {

  static const String _defaultPath = 'gs://xtream-7cb96.appspot.com/';


  static Future<void> uploadFile(XFile? file, User user) async {
      if (file == null) return;

      Reference ref = FirebaseStorage.instance.ref(_defaultPath)
          .child("images")
          .child("profile")
          .child(user.uid)
          .child(file.name);

      final metadata = SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {'picked-file-path': file.path});

      if (kIsWeb) {
        await ref.putData(await file.readAsBytes(), metadata);
      } else {
        await ref.putFile(io.File(file.path), metadata);
      }

  }

  static Future<String> viewImages() {
    return FirebaseStorage.instance.refFromURL('gs://xtream-7cb96.appspot.com/').child('2016-Lamborghini-Aventador-LP750-4-SV-012-2000.jpg').getDownloadURL();
  }

}