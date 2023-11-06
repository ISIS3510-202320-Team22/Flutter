import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guarap/components/feed/ui/post_card.dart';

class PostMethods {
  Widget uploadData(category, sortStrategy) {
    // Firestore query to order the posts based on the sortStrategy field
    Query query = FirebaseFirestore.instance
        .collection('categories')
        .doc(category)
        .collection('posts');

    if (sortStrategy == 'Recent') {
      query = query.orderBy('date', descending: true);
    } else if (sortStrategy == 'Popular') {
      query = query.orderBy('upvotes', descending: true);
    }

    return StreamBuilder(
        stream: query.snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.65,
            child: ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) => PostCard(
                snap: snapshot.data?.docs[index].data(),
              ),
            ),
          );
        }));
  }
}
