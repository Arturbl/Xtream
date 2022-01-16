

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xtream/model/user.dart';

class FirestoreController {

  static void addUser(User user) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection("users").add(user.toMap());
  }

}