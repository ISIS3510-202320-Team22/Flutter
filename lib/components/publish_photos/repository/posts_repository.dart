import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:guarap/models/user_model.dart';
import 'package:uuid/uuid.dart';

class PostRepository {
  Future<String> publishPost(
      date, description, category, image, address, upvotes) async {
    try {
      // TODO: Check user session is still valid before publishing
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final postId = const Uuid().v4();
      // Get the current user's uuid
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
      await firestore
          .collection('categories')
          .doc(category)
          .collection('posts')
          .doc(postId)
          .set({
        'date': date,
        'description': description,
        'downvotes': 0,
        'upvotes': upvotes,
        'reported': false,
        'user': username,
        'image': image,
        'address': address,
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
