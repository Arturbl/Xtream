

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xtream/model/messages/message.dart';
import 'package:xtream/model/user.dart';
import 'package:xtream/util/tuple.dart';

class FirestoreControllerApi {

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final CollectionReference _usersCol = _firestore.collection("users");
  static final CollectionReference _messagesCol = _firestore.collection('messages');


  static CollectionReference get usersCol => _usersCol;

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
  // List<String> currentIds receives a list with all userUid's in the currentUser fyp
  static Future<Tuple<List<User>, DocumentSnapshot>> loadRandomProfiles(DocumentSnapshot lastDocument, List<String> currentUids) async {
    print("(Loading data) Current id: $currentUids");
    print("(Loading data) last document: ${lastDocument.id}");
    List<User> users = [];
    QuerySnapshot querySnapshot;
    if(lastDocument.exists) {
      querySnapshot = await _usersCol.startAfterDocument(lastDocument).limit(1).get();
    } else {
      querySnapshot = await _usersCol.limit(1).get();
    }
    for(DocumentSnapshot doc in querySnapshot.docs) {
      if( !(currentUids.contains(doc.id)) ) { // doc.id == user.uid
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        print(data['name']);
        User user = User();
        user.fromMapToUser(data);
        users.add(user);
        lastDocument = doc;
      }
    }
    return Tuple(users, lastDocument);
  }
}











