import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:guarap/components/feed/repository/feed_methods.dart';
import 'package:guarap/components/feed/ui/feed.dart';
import 'package:guarap/models/post_model.dart';
import 'package:meta/meta.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FeedBloc() : super(FeedInitial()) {
    on<FeedInitialEvent>(feedInitialEvent);
    on<CategorySelectedEvent>(categorySelectedEvent);
    on<FeedSortPostsButtonClickedEvent>(feedSortPostsButtonClickedEvent);
    on<PostCardInitialEvent>(postCardInitialEvent);
    on<PostCardUpvoteEvent>(postCardUpvoteEvent);
    on<PostCardDownvoteEvent>(postCardDownvoteEvent);
    on<PostCardCancelUpvoteEvent>(postCardCancelUpvoteEvent);
    on<PostCardCancelDownvoteEvent>(postCardCancelDownvoteEvent);
  }

  FutureOr<void> feedInitialEvent(
      FeedInitialEvent event, Emitter<FeedState> emit) async {
    print("FeedInitialEvent");
    emit(FeedLoadingState());
    // Check connectivity
    String connectionStatus = await FeedMethods().checkInternetConnection();
    if (connectionStatus != "success") {
      emit(FeedErrorState(connectionStatus));
    }
    // Retrieve the feed for the selected category
    List<PostModel> posts =
        await FeedMethods().getPostsByCategory("Generic", "Recent");
    emit(FeedLoadedState("Generic", "Recent", posts));
  }

  FutureOr<void> categorySelectedEvent(
      CategorySelectedEvent event, Emitter<FeedState> emit) async {
    emit(FeedLoadingState(event.category, event.sortStrategy));
    // Check connectivity
    String connectionStatus = await FeedMethods().checkInternetConnection();
    if (connectionStatus != "success") {
      emit(FeedErrorState(connectionStatus));
    }
    // Retrieve the feed for the selected category
    List<PostModel> posts = await FeedMethods()
        .getPostsByCategory(event.category, event.sortStrategy);
    emit(FeedLoadedState(event.category, event.sortStrategy, posts));
  }

  FutureOr<void> feedSortPostsButtonClickedEvent(
      FeedSortPostsButtonClickedEvent event, Emitter<FeedState> emit) async {
    emit(FeedLoadingState(event.category, event.sortStrategy));
    // Check connectivity
    String connectionStatus = await FeedMethods().checkInternetConnection();
    if (connectionStatus != "success") {
      emit(FeedErrorState(connectionStatus));
    }
    // Retrieve the feed for the selected category
    List<PostModel> posts = await FeedMethods()
        .getPostsByCategory(event.category, event.sortStrategy);
    emit(FeedLoadedState(event.category, event.sortStrategy, posts));
  }

  // Post Card Events
  FutureOr<void> postCardInitialEvent(PostCardInitialEvent event, Emitter<FeedState> emit) async {
    // Get the post upvotes and downvotes
    
  }

  FutureOr<void> postCardUpvoteEvent(PostCardUpvoteEvent event, Emitter<FeedState> emit) async {
    String connectionStatus = await FeedMethods().checkInternetConnection();
    if (connectionStatus != "success") {
      emit(FeedErrorState(connectionStatus));
      return;
    }
    // Update the ui
    emit(PostUpvoteState(event.post.id!));
  }

  FutureOr<void> postCardDownvoteEvent(PostCardDownvoteEvent event, Emitter<FeedState> emit) async {
    String connectionStatus = await FeedMethods().checkInternetConnection();
    if (connectionStatus != "success") {
      emit(FeedErrorState(connectionStatus));
      return;
    }
    emit(PostDownvoteState(event.post.id!));
  }

  FutureOr<void> postCardCancelUpvoteEvent(PostCardCancelUpvoteEvent event, Emitter<FeedState> emit) async {
    String connectionStatus = await FeedMethods().checkInternetConnection();
    if (connectionStatus != "success") {
      emit(FeedErrorState(connectionStatus));
      return;
    }
    // Update the ui
    emit(PostCancelUpvoteState(event.post.id!, event.downVoted));
  }

  FutureOr<void> postCardCancelDownvoteEvent(PostCardCancelDownvoteEvent event, Emitter<FeedState> emit) async {
    String connectionStatus = await FeedMethods().checkInternetConnection();
    if (connectionStatus != "success") {
      emit(FeedErrorState(connectionStatus));
      return;
    }
    // Update the ui
    if (event.upVoted) {
      print("upvoted");
    }
    print("downvoted Canceled");
    emit(PostCancelDownvoteState(event.post.id!, event.upVoted));
  }
}
