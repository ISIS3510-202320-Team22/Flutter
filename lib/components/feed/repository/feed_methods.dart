import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      for (int i = 0; i < snapshot.docs.length; i++) {
        posts.add(PostModel.fromDocument(snapshot.docs[i]));
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
      return "No internet connection";
    }
  }

  Future<String> upvotePost(postId) async {
    try {
      // Check if the user is logged in
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return "You must be logged in to vote";
      }
      // Loop over all the categories
      QuerySnapshot categoriesSnapshot =
          await _firestore.collection('categories').get();
      for (int i = 0; i < categoriesSnapshot.docs.length; i++) {
        // Loop over all the posts in the category
        QuerySnapshot postsSnapshot = await _firestore
            .collection('categories')
            .doc(categoriesSnapshot.docs[i].id)
            .collection('posts')
            .get();
        for (int j = 0; j < postsSnapshot.docs.length; j++) {
          // Check if the post is the one we want to upvote
          if (postsSnapshot.docs[j].id == postId) {
            // Add upvote to the post
            await _firestore
                .collection('categories')
                .doc(categoriesSnapshot.docs[i].id)
                .collection('posts')
                .doc(postsSnapshot.docs[j].id)
                .update({'upvotes': FieldValue.increment(1)});
          }
        }
      }
      return "success";
    } on FirebaseException catch (e) {
      return e.message!;
    }
  }

  Future<String> downvotePost(postId) async {
    try {
      // Check if the user is logged in
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return "You must be logged in to vote";
      }
      // Loop over all the categories
      QuerySnapshot categoriesSnapshot =
          await _firestore.collection('categories').get();
      for (int i = 0; i < categoriesSnapshot.docs.length; i++) {
        // Loop over all the posts in the category
        QuerySnapshot postsSnapshot = await _firestore
            .collection('categories')
            .doc(categoriesSnapshot.docs[i].id)
            .collection('posts')
            .get();
        for (int j = 0; j < postsSnapshot.docs.length; j++) {
          // Check if the post is the one we want to upvote
          if (postsSnapshot.docs[j].id == postId) {
            // Add upvote to the post
            await _firestore
                .collection('categories')
                .doc(categoriesSnapshot.docs[i].id)
                .collection('posts')
                .doc(postsSnapshot.docs[j].id)
                .update({'downvotes': FieldValue.increment(1)});
          }
        }
      }
      return "success";
    } on FirebaseException catch (e) {
      return e.message!;
    }
  }

  Future<String> cancelUpvotePost(postId) async {
    try {
      // Check if the user is logged in
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return "You must be logged in to vote";
      }
      // Loop over all the categories
      QuerySnapshot categoriesSnapshot =
          await _firestore.collection('categories').get();
      for (int i = 0; i < categoriesSnapshot.docs.length; i++) {
        // Loop over all the posts in the category
        QuerySnapshot postsSnapshot = await _firestore
            .collection('categories')
            .doc(categoriesSnapshot.docs[i].id)
            .collection('posts')
            .get();
        for (int j = 0; j < postsSnapshot.docs.length; j++) {
          // Check if the post is the one we want to upvote
          if (postsSnapshot.docs[j].id == postId) {
            // Add upvote to the post
            await _firestore
                .collection('categories')
                .doc(categoriesSnapshot.docs[i].id)
                .collection('posts')
                .doc(postsSnapshot.docs[j].id)
                .update({'upvotes': FieldValue.increment(-1)});
          }
        }
      }
      return "success";
    } on FirebaseException catch (e) {
      return e.message!;
    }
  }

  Future<String> cancelDownvotePost(postId) async {
    try {
      // Check if the user is logged in
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return "You must be logged in to vote";
      }
      // Loop over all the categories
      QuerySnapshot categoriesSnapshot =
          await _firestore.collection('categories').get();
      for (int i = 0; i < categoriesSnapshot.docs.length; i++) {
        // Loop over all the posts in the category
        QuerySnapshot postsSnapshot = await _firestore
            .collection('categories')
            .doc(categoriesSnapshot.docs[i].id)
            .collection('posts')
            .get();
        for (int j = 0; j < postsSnapshot.docs.length; j++) {
          // Check if the post is the one we want to upvote
          if (postsSnapshot.docs[j].id == postId) {
            // Add upvote to the post
            await _firestore
                .collection('categories')
                .doc(categoriesSnapshot.docs[i].id)
                .collection('posts')
                .doc(postsSnapshot.docs[j].id)
                .update({'downvotes': FieldValue.increment(-1)});
          }
        }
      }
      return "success";
    } on FirebaseException catch (e) {
      return e.message!;
    }
  }
}