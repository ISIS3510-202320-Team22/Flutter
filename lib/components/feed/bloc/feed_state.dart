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

class FeedUpVoteState extends FeedActionState {}

class FeedErrorState extends FeedActionState {
  final String message;
  FeedErrorState(this.message);
}
