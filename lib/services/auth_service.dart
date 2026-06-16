import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  // REGISTER

  Future<User?> registerUser({
    required String email,
    required String password,
  }) async {

    try {

      UserCredential userCredential =
      await _auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential.user;

    } on FirebaseAuthException catch (e) {

      throw e.message ?? "Registration Failed";
    }
  }

  // LOGIN

  Future<User?> loginUser({
    required String email,
    required String password,
  }) async {

    try {

      UserCredential userCredential =
      await _auth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential.user;

    } on FirebaseAuthException catch (e) {

      throw e.message ?? "Login Failed";
    }
  }

  // LOGOUT

  Future<void> logout() async {

    await _auth.signOut();
  }
}