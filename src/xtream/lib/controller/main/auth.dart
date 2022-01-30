import 'package:firebase_auth/firebase_auth.dart';
import 'package:xtream/controller/main/firestoreApi.dart';
import 'package:xtream/model/user.dart' as userClass;

class Auth {


  static void _saveUserDataIntoCloudFirestore(String name, User firebaseUser) async {
    await FirestoreControllerApi.getAppTotalUsers().then((int totalUsers){
      final newUser = userClass.User();
      newUser.uid = firebaseUser.uid;
      newUser.id = totalUsers + 1;
      newUser.name = name;
      newUser.email = firebaseUser.email!;
      FirestoreControllerApi.addUser(newUser);
    });
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



  static Future<String> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      ).then((UserCredential userCredential) => FirestoreControllerApi.updateUserOnlineStatus(userCredential.user!.uid, true));
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
    return "done";
  }

  static Future<void> signOut() async {
    userClass.User user = await Auth.getCurrentUser();
    await FirebaseAuth.instance.signOut().then((value) => FirestoreControllerApi.updateUserOnlineStatus(user.uid, false));
  }

  static Future<userClass.User> getCurrentUser() async {
    userClass.User user = userClass.User();
    User? firebaseUser =  FirebaseAuth.instance.currentUser;
    if(firebaseUser != null) {
      if(firebaseUser.isAnonymous) {
        user.isAnonymous = true;
        user.uid = firebaseUser.uid;
      } else {
        user =  await FirestoreControllerApi.getUserData(firebaseUser.uid);
        user.isAnonymous = false;
      }
    }
    return user;
  }



}