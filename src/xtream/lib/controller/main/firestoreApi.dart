

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xtream/model/user.dart';

class FirestoreControllerApi {

  static void addUser(User user) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection("users").doc(user.uid).set(user.toMap());
  }

  static Future<bool> updateUser(User user) async {
    bool updated = false;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('users')
        .doc(user.uid)
        .update(user.toMap())
        .then((value) => updated = true)
        .catchError((error) => updated = false);
    return updated;
  }

  static Future<User> getUserData(String uid) async {
    User user = User();
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('users')
        .doc(uid)
        .get();
    if (documentSnapshot.exists) {
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
      user.uid = data['uid'];
      user.name = data['name'];
      user.gender = data['gender'];
      user.ethnicity = data['ethnicity'];
      user.email = data['email'];
      user.age = data['age'];
      user.setProfileImage(data['images']['profile']);
      user.images = data['images']['other'];
      user.country = data['country'];
      user.evaluation = data['evaluation'];
    }

    return user;
  }


}