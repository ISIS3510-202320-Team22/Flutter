import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guarap/components/feed/repository/posts_methods.dart';
import 'package:guarap/components/feed/ui/post_card.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() {
    return _Feed();
  }
}

class _Feed extends State<Feed> {
  @override
  Widget build(context) {
    return Scaffold(
      body: PostMethods().uploadData(),
    );
  }
}
