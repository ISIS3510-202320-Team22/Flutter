part of 'feed_bloc.dart';

@immutable
abstract class FeedEvent {}

class FeedInitialEvent extends FeedEvent {
  FeedInitialEvent();
}

class CategorySelectedEvent extends FeedEvent {
  final String category;

  final String sortStrategy;

  CategorySelectedEvent({required this.category, required this.sortStrategy});
}

class FeedUpvoteEvent extends FeedEvent {}

class FeedSortPostsButtonClickedEvent extends FeedEvent {
  final String category;
  final String sortStrategy;
  final List<PostModel> posts;
  FeedSortPostsButtonClickedEvent(
      {required this.sortStrategy,
      required this.category,
      required this.posts});
}
