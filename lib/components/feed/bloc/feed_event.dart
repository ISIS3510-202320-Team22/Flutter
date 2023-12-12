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

// Post Card Events
class PostCardInitialEvent extends FeedEvent {
  final PostModel post;
  PostCardInitialEvent({required this.post});
}

class PostCardUpvoteEvent extends FeedEvent {
  final PostModel post;
  PostCardUpvoteEvent({required this.post});
}

class PostCardDownvoteEvent extends FeedEvent {
  final PostModel post;
  PostCardDownvoteEvent({required this.post});
}

class PostCardCancelUpvoteEvent extends FeedEvent {
  final PostModel post;
  final bool downVoted;
  PostCardCancelUpvoteEvent({required this.post, required this.downVoted});
}

class PostCardCancelDownvoteEvent extends FeedEvent {
  final PostModel post;
  final bool upVoted;
  PostCardCancelDownvoteEvent({required this.post, required this.upVoted});
}

class PostCardReportEvent extends FeedEvent {
  final PostModel post;
  PostCardReportEvent({required this.post});
}

class ReportPostSubmitEvent extends FeedEvent {
  final String postId;
  final String postUserId;
  final String userReportingId;
  final String description;
  ReportPostSubmitEvent(
      {required this.postId,
      required this.postUserId,
      required this.userReportingId,
      required this.description});
}
