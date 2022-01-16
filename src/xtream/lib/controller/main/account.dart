
import 'package:firebase_auth/firebase_auth.dart';

class Account {

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

}