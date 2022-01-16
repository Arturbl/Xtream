
import 'package:firebase_auth/firebase_auth.dart';

class Auth {

  static Future<bool> registerNewUser(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
    } on FirebaseAuthException catch (e) {
      return false;
    } catch (e) {
      return false;
    }
    return true;
  }


  static Future<bool> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return false;
    }
    return true;
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

}