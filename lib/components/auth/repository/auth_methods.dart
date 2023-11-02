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

  Future<String> logoutUser() async {
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
      if (e.code == 'user-not-found') {
        return "User not found for this email address";
      } else if (e.code == 'invalid-email') {
        return "Invalid email";
      } else {
        return "Unknown error";
      }
    }
  }

  Future<String> createUser(
      {required String email,
      required String username,
      required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
        'username': username,
        'email': email,
        'uid': _auth.currentUser!.uid,
        'createdAt': DateTime.now(),
        'updatedAt': DateTime.now(),
      });
      return "success";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    } on FirebaseException catch (e) {
      return e.message.toString();
    }
  }

  Future<String> checkUsername({required String username}) async {
    // Check if the username already exists
    try {
      final QuerySnapshot result = await _firestore
          .collection('users')
          .where('username', isEqualTo: username)
          .get();
      final List<DocumentSnapshot> documents = result.docs;
      if (documents.isNotEmpty) {
        return "Username already exists";
      } else {
        return "success";
      }
    } on FirebaseException catch (e) {
      return "Unknown error";
    }
  }

  Future<String> checkEmail({required String email}) async {
    // Check if the email already exists
    try {
      final QuerySnapshot result = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
      final List<DocumentSnapshot> documents = result.docs;
      if (documents.isNotEmpty) {
        return "Email already exists";
      } else {
        return "success";
      }
    } on FirebaseException catch (e) {
      return "Unknown error";
    }
  }
}
