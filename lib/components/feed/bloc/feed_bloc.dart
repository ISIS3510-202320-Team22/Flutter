import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:guarap/components/feed/repository/feed_methods.dart';
import 'package:guarap/models/post_model.dart';
import 'package:meta/meta.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FeedBloc() : super(FeedInitial()) {
    on<FeedInitialEvent>(feedInitialEvent);
    on<CategorySelectedEvent>(categorySelectedEvent);
    on<FeedUpvoteEvent>(feedUpVoteEvent);
    on<FeedSortPostsButtonClickedEvent>(feedSortPostsButtonClickedEvent);
  }

  FutureOr<void> feedInitialEvent(
      FeedInitialEvent event, Emitter<FeedState> emit) async {
    emit(FeedLoadingState());
    // Check connectivity
    String connectionStatus = await FeedMethods().checkInternetConnection();
    if (connectionStatus != "success") {
      emit(FeedErrorState(connectionStatus));
      return;
    }
    // Retrieve the feed for the selected category
    await FeedMethods()
        .getPostsByCategory("Generic", "Recent")
        .then((posts) => emit(FeedLoadedState("Generic", "Recent", posts)));
  }

  FutureOr<void> categorySelectedEvent(
      CategorySelectedEvent event, Emitter<FeedState> emit) async {
    emit(FeedLoadingState(event.category, event.sortStrategy));
    // Check connectivity
    String connectionStatus = await FeedMethods().checkInternetConnection();
    if (connectionStatus != "success") {
      emit(FeedErrorState(connectionStatus));
      return;
    }
    // Retrieve the feed for the selected category
    List<PostModel> posts = await FeedMethods()
        .getPostsByCategory(event.category, event.sortStrategy);
    emit(FeedLoadedState(event.category, event.sortStrategy, posts));
  }

  FutureOr<void> feedUpVoteEvent(
      FeedUpvoteEvent event, Emitter<FeedState> emit) {
    emit(FeedUpVoteState());
  }

  FutureOr<void> feedSortPostsButtonClickedEvent(
      FeedSortPostsButtonClickedEvent event, Emitter<FeedState> emit) async {
    emit(FeedLoadingState(event.category, event.sortStrategy));
    // Retrieve the feed for the selected category
    List<PostModel> posts = await FeedMethods()
        .getPostsByCategory(event.category, event.sortStrategy);
    emit(FeedLoadedState(event.category, event.sortStrategy, posts));
  }
}
