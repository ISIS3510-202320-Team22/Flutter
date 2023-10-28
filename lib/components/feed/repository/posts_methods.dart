import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guarap/components/feed/ui/post_card.dart';

class PostMethods {
  Widget uploadData(category) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('categories')
          .doc(category)
          .collection("posts")
          .snapshots(),
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => PostCard(
                    snap: snapshot.data!.docs[index].data(),
                  )),
        );
      },
    );
  }
}
