import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guarap/components/feed/bloc/feed_bloc.dart';
import 'package:guarap/components/feed/ui/post_card.dart';
import 'package:guarap/models/post_model.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  State<Feed> createState() {
    return _Feed();
  }
}

class _Feed extends State<Feed> {
  bool _feedLoading = false;
  String _selectedCategory = "Generic";
  String _sortStrategy = "Recent";
  List<PostModel> _posts = [];

  @override
  void initState() {
    feedBloc.add(FeedInitialEvent());
    super.initState();
  }

  final FeedBloc feedBloc = FeedBloc();

  @override
  Widget build(context) {
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;

    final List<String> categories = [
      'Generic',
      'Chismes',
      'Emprendimientos',
      'Atardeceres',
      'LookingFor',
    ];

    return BlocConsumer<FeedBloc, FeedState>(
      bloc: feedBloc,
      listenWhen: (previous, current) => current is FeedActionState,
      buildWhen: (previous, current) => current is! FeedActionState,
      listener: (context, state) {
        switch (state.runtimeType) {
          case FeedErrorState:
            final feedErrorState = state as FeedErrorState;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(feedErrorState.message),
                backgroundColor: Colors.red,
              ),
            );
            break;
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case FeedLoadingState:
            _feedLoading = true;
            _selectedCategory = (state as FeedLoadingState).category;
            _sortStrategy = state.sortStrategy;
            analytics.logEvent(name: 'screen_view', parameters: {
              'screen_name': 'feed',
              'category': _selectedCategory,
              'sort_strategy': _sortStrategy,
            });
            break;

          case FeedLoadedState:
            _feedLoading = false;
            final feedLoadedState = state as FeedLoadedState;
            _selectedCategory = feedLoadedState.category;
            _posts = feedLoadedState.posts;
            _sortStrategy = feedLoadedState.sortStrategy;
            analytics.logEvent(name: 'screen_view', parameters: {
              'screen_name': 'feed',
              'category': _selectedCategory,
              'sort_strategy': _sortStrategy,
            });
            break;
          default:
            _feedLoading = false;
            _selectedCategory = "Generic";
            _posts = [];
            _sortStrategy = "Recent";
            analytics.logEvent(name: 'screen_view', parameters: {
              'screen_name': 'feed',
              'category': _selectedCategory,
              'sort_strategy': _sortStrategy,
            });
        }
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Text(
                  "Guarap",
                  style: GoogleFonts.pattaya(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontSize: 40),
                ),
                const Spacer(),
                IconButton(
                  icon: _sortStrategy == "Recent"
                      ? const Icon(Icons.access_time)
                      : const Icon(Icons.arrow_upward),
                  onPressed: () => feedBloc.add(FeedSortPostsButtonClickedEvent(
                      category: _selectedCategory,
                      sortStrategy:
                          _sortStrategy == "Recent" ? "Popular" : "Recent",
                      posts: _posts)),
                )
              ],
            ),
          ),
          body: Column(
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
                          // Change the feed for the specific category
                          feedBloc.add(CategorySelectedEvent(
                            category: _selectedCategory,
                            sortStrategy: _sortStrategy,
                          ));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: _selectedCategory == categories[index]
                                ? const Color.fromARGB(255, 171, 0, 72)
                                : Colors.grey.withOpacity(0.8),
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
              // Show the feed for the selected category if it is not loading
              _feedLoading
                  ?
                  // Show a loading indicator if the feed center
                  // is loading
                  const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  // Show the feed for the selected category
                  : Expanded(
                      child: ListView.builder(
                      itemCount: _posts.length,
                      itemBuilder: (context, index) =>
                          PostCard(post: _posts[index]),
                    ))
            ],
          ),
        );
      },
    );
  }
}
