import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:guarap/models/user_model.dart';
import 'package:uuid/uuid.dart';

class SettingsMethods {
  Future<String> publishReportBug(title, description) async {
    final bugReportId = const Uuid().v4();
    try {
      // TODO: Check user session is still valid before publishing
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final uuid = FirebaseAuth.instance.currentUser!.uid;
      // Get the document reference
      final userDocRef = firestore.collection('users').doc(uuid).withConverter(
          fromFirestore: UserModel.fromFirestore,
          toFirestore: (UserModel user, _) => user.toFirestore());
      final userDocSnap = await userDocRef.get();
      final user = userDocSnap.data(); // Convert to UserModel
      if (user == null) {
        return "User not found";
      }
      final username = user.username;
      await firestore.collection('bugReports').doc(bugReportId).set({
        'title': title,
        'description': description,
        'user': username,
      });
      return "success";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> checkInternetConnection() async {
    try {
      final response = await Dio().get('https://www.google.com/');
      if (response.statusCode == 200) {
        return "success";
      } else {
        return "Unknown error";
      }
    } on DioException catch (e) {
      return "No internet connection";
    }
  }
}
