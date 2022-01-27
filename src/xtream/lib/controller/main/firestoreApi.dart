

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xtream/model/messages/message.dart';
import 'package:xtream/model/user.dart';
import 'package:xtream/util/tuple.dart';

class FirestoreControllerApi {

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final CollectionReference _usersCol = _firestore.collection("users");
  static final CollectionReference _appInfo = _firestore.collection('data');
  static final CollectionReference _messagesCol = _firestore.collection('messages');


  static CollectionReference get usersCol => _usersCol;

  static Future<int> getAppTotalUsers() async {
    DocumentSnapshot documentSnapshot = await _appInfo.doc('statistics').get();
    if(documentSnapshot != null) {
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
      return data['totalUsers'];
    }
    return 0;
  }

  static Future<void> addUser(User user) async {
    await getAppTotalUsers().then((int totalUsers) {
      int newTotalUsers = totalUsers + 1;
      _usersCol.doc(user.uid).set(user.toMap()); // add user
      _appInfo.doc('statistics').set({'totalUsers': newTotalUsers}); // increment users
    });
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

  static Future<DocumentSnapshot> _getRandomStartingPointAtCollection() async {
    int totalUsers = await getAppTotalUsers();
    int randomId = Random().nextInt( (totalUsers * 0.80).toInt() ); // prevent from going to the end of the array
    QuerySnapshot snapshot = await _usersCol.where('id', isEqualTo: randomId).get();
    return snapshot.docs.first;
  }


  static Future<List<User>> loadRandomProfiles(List<String> currentUids) async {
    int totalAppUsers = await getAppTotalUsers() - 1;
    List<User> users = [];
    // select a random starting point at the collection
    DocumentSnapshot startingPointDocument = await _getRandomStartingPointAtCollection();
    QuerySnapshot querySnapshot = await _usersCol.startAfterDocument(startingPointDocument).limit(2).get();
    for(DocumentSnapshot doc in querySnapshot.docs) {
      if( !(currentUids.contains(doc.id)) ) { // doc.id == user.uid
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        User user = User();
        user.fromMapToUser(data);
        users.add(user);
      } else if(currentUids.length < totalAppUsers) {
        return loadRandomProfiles(currentUids);
      }
    }
    return users;
  }
}











