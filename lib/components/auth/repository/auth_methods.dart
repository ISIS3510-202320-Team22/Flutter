import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "User not found";
      } else if (e.code == 'wrong-password') {
        return "Wrong password";
      }
      return "Unknown error";
    }
  }

  Future<String> logoutUser() async{
    try {
      await _auth.signOut();
      return "success";
    } on FirebaseAuthException catch (e) {
      return "Unknown error $e";
    }
  }

  Future<String> recoverAccount({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return "success";
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'user-not-found') {
        return "User not found for this email address";
      } else if (e.code == 'invalid-email') {
        return "Invalid email";
      } else {
        return "Unknown error";
      }
    }
  }
}
