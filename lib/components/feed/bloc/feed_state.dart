part of 'feed_bloc.dart';

@immutable
sealed class FeedState {}

abstract class FeedActionState extends FeedState {}

final class FeedInitial extends FeedState {}

class FeedLoadedState extends FeedState {
  final String category;
  final String sortStrategy;
  final List<PostModel> posts;

  FeedLoadedState(this.category, this.sortStrategy, this.posts);
}

class FeedLoadingState extends FeedState {
  final String category;
  final String sortStrategy;
  FeedLoadingState([this.category = "Generic", this.sortStrategy = "Recent"]);
}

class FeedErrorState extends FeedActionState {
  final String message;
  FeedErrorState(this.message);
}

// Post Card States

class PostCardInitial extends FeedState {
  final bool upVoted;
  final bool downVoted;
  PostCardInitial(this.upVoted, this.downVoted);
}

class PostUpvoteState extends FeedState {
  final String postId;
  PostUpvoteState(this.postId);
}

class PostDownvoteState extends FeedState {
  final String postId;
  PostDownvoteState(this.postId);
}

class PostCancelUpvoteState extends FeedState {
  final String postId;
  final bool downVoted;
  PostCancelUpvoteState(this.postId, this.downVoted);
}

class PostCancelDownvoteState extends FeedState {
  final String postId;
  final bool upVoted;
  PostCancelDownvoteState(this.postId, this.upVoted);
}

class PostReportPageActionState extends FeedActionState {
  final PostModel post;
  PostReportPageActionState({required this.post});
}

class ReportPageInitial extends FeedState {}

class ReportPageLoadingState extends FeedState {}

class ReportPageSuccessState extends FeedActionState {}
