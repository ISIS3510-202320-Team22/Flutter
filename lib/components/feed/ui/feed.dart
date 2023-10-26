import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guarap/components/feed/bloc/feed_bloc.dart';
import 'package:guarap/components/feed/repository/posts_methods.dart';
import 'package:guarap/components/publish_photos/ui/publish_photo.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() {
    return _Feed();
  }
}

class _Feed extends State<Feed> {
  Category _selectedCategory = Category.Emprendimientos;
  final FeedBloc feedBloc = FeedBloc();

  @override
  Widget build(context) {
    return BlocConsumer<FeedBloc, FeedState>(
      bloc: feedBloc,
      listenWhen: (previous, current) => current is FeedActionState,
      buildWhen: (previous, current) => current is! FeedActionState,
      listener: (context, state) {},
      builder: (context, state) {
        return PostMethods().uploadData(_selectedCategory);
      },
    );
  }
}
