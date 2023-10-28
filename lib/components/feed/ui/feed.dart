import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guarap/components/feed/bloc/feed_bloc.dart';
import 'package:guarap/components/feed/repository/posts_methods.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() {
    return _Feed();
  }
}

class _Feed extends State<Feed> {
  String _selectedCategory = 'Emprendimientos';
  final FeedBloc feedBloc = FeedBloc();

  @override
  Widget build(context) {
    final List<String> categories = [
      'Generic',
      'Chismes',
      'Emprendimientos',
      'Eventos',
      'Atardeceres',
      'LookingFor',
    ];

    return BlocConsumer<FeedBloc, FeedState>(
      bloc: feedBloc,
      listenWhen: (previous, current) => current is FeedActionState,
      buildWhen: (previous, current) => current is! FeedActionState,
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case FeedLoadingState:
            final loading = true;
            return const Center(child: CircularProgressIndicator());

          case CategorySelectedState:
            final categorySelectedState = state as CategorySelectedState;
            _selectedCategory = categorySelectedState.category;
            break;
        }
        return Column(
          children: [
            SizedBox(
              height: 55,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        _selectedCategory = categories[index];
                        feedBloc.add(
                            CategorySelectedEvent(category: _selectedCategory));
                        print(categories[index]);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 171, 0, 72),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          categories[index],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Photos Feed
            PostMethods().uploadData(_selectedCategory),
          ],
        );
      },
    );
  }
}
