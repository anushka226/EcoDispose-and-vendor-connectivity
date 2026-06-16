import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore firestore =
      FirebaseFirestore.instance;

  // =========================
  // USER REGISTER
  // =========================

  static Future registerUser({
    required String fullName,
    required String username,
    required String email,
    required String phone,
    required String password,
  }) async {
    UserCredential userCredential =
    await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    String uid = userCredential.user!.uid;

    await firestore.collection('users').doc(uid).set({
      'uid': uid,
      'fullName': fullName,
      'username': username,
      'email': email,
      'phone': phone,
      'role': 'user',
      'createdAt': DateTime.now(),
    });
  }

  // =========================
  // VENDOR REGISTER
  // =========================

  static Future registerVendor({
    required String companyName,
    required String vendorName,
    required String email,
    required String phone,
    required String password,
  }) async {
    UserCredential userCredential =
    await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    String uid = userCredential.user!.uid;

    await firestore.collection('vendors').doc(uid).set({
      'uid': uid,
      'companyName': companyName,
      'vendorName': vendorName,
      'email': email,
      'phone': phone,
      'role': 'vendor',
      'createdAt': DateTime.now(),
    });
  }

  // =========================
  // LOGIN
  // =========================

  static Future login({
    required String email,
    required String password,
  }) async {
    await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // =========================
  // LOGOUT
  // =========================

  static Future logout() async {
    await auth.signOut();
  }
}