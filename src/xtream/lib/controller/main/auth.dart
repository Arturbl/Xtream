import 'package:firebase_auth/firebase_auth.dart';
import 'package:xtream/controller/main/firestore.dart';
import 'package:xtream/model/user.dart' as userClass;

class Auth {


  static void _saveUserDataIntoCloudFirestore(String name, User firebaseUser) {
    final newUser = userClass.User();
    newUser.uid = firebaseUser.uid;
    newUser.name = name;
    newUser.email = firebaseUser.email!;
    FirestoreController.addUser(newUser);
  }

  static Future<String> registerNewUser(String email, String password, String name) async {
    try {

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      ).then((value) => _saveUserDataIntoCloudFirestore(name, value.user as User));

    } on FirebaseAuthException catch (e) {
      return e.code;
    }
    return "done";
  }

  static void deleteCurrentAnonymousSession() async {
    User? firebaseUser =  FirebaseAuth.instance.currentUser;
    if(firebaseUser != null && firebaseUser.isAnonymous) {
      await firebaseUser.delete();
    }
  }


  static Future<String> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
    return "done";
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<userClass.User> getCurrentUser() async {
    userClass.User user = userClass.User();
    User? firebaseUser =  FirebaseAuth.instance.currentUser;
    if(firebaseUser != null) {
      if(firebaseUser.isAnonymous) {
        user.isAnonymous = true;
        user.uid = firebaseUser.uid;
      } else {
        user =  await FirestoreController.getUserData(firebaseUser.uid);
        user.isAnonymous = false;
      }
    }
    return user;
  }



}