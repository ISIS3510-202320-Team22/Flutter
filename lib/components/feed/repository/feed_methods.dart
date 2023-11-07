import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guarap/models/post_model.dart';
import 'package:dio/dio.dart';

class FeedMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Firestore persistence is enabled by default on Android and iOS.

  // Retrieve the feed for the selected category
  Future<List<PostModel>> getPostsByCategory(category, sortStrategy) {
    // Firestore query to order the posts based on the sortStrategy field
    Query query =
        _firestore.collection('categories').doc(category).collection('posts');

    if (sortStrategy == 'Recent') {
      query = query.orderBy('date', descending: true);
    } else if (sortStrategy == 'Popular') {
      query = query.orderBy('upvotes', descending: true);
    }

    return query.get().then((snapshot) {
      List<PostModel> posts = [];
      print(PostModel.fromDocument(snapshot.docs[0]).date?.toDate().toString());
      for (QueryDocumentSnapshot doc in snapshot.docs) {
        posts.add(PostModel.fromDocument(doc));
      }
      return posts;
    });
  }

  // Check connectivity
  Future<String> checkInternetConnection() async {
    try {
      final response = await Dio().get('https://www.google.com/');
      if (response.statusCode == 200) {
        return "success";
      } else {
        return "Unknown error";
      }
    } on DioException catch (e) {
      return e.toString();
    }
  }
}
