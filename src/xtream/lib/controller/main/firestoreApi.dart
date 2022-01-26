

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xtream/model/user.dart';

class FirestoreControllerApi {

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final CollectionReference _usersCol = _firestore.collection("users");
  static final CollectionReference _messagesCol = _firestore.collection('messages');

  static void addUser(User user) {
    _usersCol.doc(user.uid).set(user.toMap());
  }

  static Future<bool> updateUser(User user) async {
    bool updated = false;
    await _usersCol.doc(user.uid)
        .update(user.toMap())
        .then((value) => updated = true)
        .catchError((error) => updated = false);
    return updated;
  }

  static Future<User> getUserData(String uid) async {
    User user = User();
    DocumentSnapshot documentSnapshot = await _usersCol.doc(uid).get();
    if (documentSnapshot.exists) {
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
      user.fromMapToUser(data);
    }
    return user;
  }


  // get all conversations of current user
  static  Stream<QuerySnapshot> loadConversations(User user)   {
    return _messagesCol.doc(user.uid).collection('to').orderBy("date", descending: true).snapshots();
  }

  // load profiles to home page (can only load 30 at a time)
  // reloads when user is on last profile - 5;
  static Future<List<User>> loadProfiles(User currentUser) async {
    List<User> users = [];
    QuerySnapshot querySnapshot = await _usersCol.where("uid", isNotEqualTo: currentUser.uid).limit(3).get();
    for(DocumentSnapshot doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      User user = User();
      user.fromMapToUser(data);
      users.add(user);
    }
    return users;
  }

}