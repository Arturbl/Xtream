

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xtream/model/messages/messageData.dart';
import 'package:xtream/model/user.dart';

class FirestoreControllerApi {

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final CollectionReference _messagesCol = _firestore.collection('messages'); // manage messages data
  static final CollectionReference rooms = _firestore.collection('rooms'); // menage users stream
  static final CollectionReference _usersCol = _firestore.collection("users"); // manage users
  static final CollectionReference appInfo = _firestore.collection('data'); // mensage private app stats


  static CollectionReference get usersCol => _usersCol;

  static Future<Map<String, dynamic>> getAppStats() async {
    DocumentSnapshot documentSnapshot = await appInfo.doc('statistics').get();
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    return data;
  }

  static Future<void> updateStreamsCounter(bool increase) async  {
    Map<String, dynamic> data = await FirestoreControllerApi.getAppStats();
    int counter = increase ? data['streams'] + 1 : data['streams'] - 1;
    FirestoreControllerApi.appInfo.doc('statistics').update({'streams': counter}); // update app stats in firebase
  }

  static Future<void> addUser(User user) async {
    await getAppStats().then((Map<String, dynamic> stats) {
      int newTotalUsers = stats['totalUsers'] + 1;
      _usersCol.doc(user.uid).set(user.toMap()); // add user
      appInfo.doc('statistics').update({'totalUsers': newTotalUsers}); // increment users
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

  static Stream<DocumentSnapshot> listenToUser(String userUid) {
    return _usersCol.doc(userUid).snapshots();
  }

  // get all conversations of current user
  static  Stream<QuerySnapshot> loadConversations(User user)   {
    return _messagesCol.doc(user.uid).collection('to').orderBy("date", descending: true).snapshots();
  }


  static Stream<DocumentSnapshot> loadChatMessages(String currentUserUid, String toUserUid) {
    return _messagesCol.doc(currentUserUid).collection('to').doc(toUserUid).snapshots();
  }

  static Future<void> updateUserOnlineStatus(String userUid, bool value) async {
    User user = await getUserData(userUid);
    user.online = value;
    updateUser(user);
  }

  static void sendMessage(String currentUserUid, String currentUserName, String toUserUid, MessageData messageData) {
    _messagesCol.doc(currentUserUid).collection('to').doc(toUserUid).set(messageData.toMap()); // save conversation  to current user
    messageData.toUserUid = currentUserUid;
    messageData.toUserName = currentUserName;
    _messagesCol.doc(toUserUid).collection('to').doc(currentUserUid).set(messageData.toMap()); // save conversation to another user
  }

  static Future<DocumentSnapshot> _getRandomStartingPointAtCollection() async {
    Map<String, dynamic> data = await getAppStats();
    int randomId = Random().nextInt( (data['totalUsers'] * 0.80).toInt() ); // prevent from going to the end of the array
    QuerySnapshot snapshot = await _usersCol.where('id', isEqualTo: randomId).get();
    return snapshot.docs.first;
  }


  // this method can be used if in home, we decide to display profiles
  static Future<List<User>> loadRandomProfiles(List<String> currentUids) async {
    Map<String, dynamic> data = await getAppStats();
    int totalAppUsers = data['totalUsers'] - 1;
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











