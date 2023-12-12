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
    on<FeedSortPostsButtonClickedEvent>(feedSortPostsButtonClickedEvent);
    on<PostCardInitialEvent>(postCardInitialEvent);
    on<PostCardUpvoteEvent>(postCardUpvoteEvent);
    on<PostCardDownvoteEvent>(postCardDownvoteEvent);
    on<PostCardCancelUpvoteEvent>(postCardCancelUpvoteEvent);
    on<PostCardCancelDownvoteEvent>(postCardCancelDownvoteEvent);
    on<PostCardReportEvent>(postCardReportEvent);
    on<ReportPostSubmitEvent>(reportPostSubmitEvent);
  }

  FutureOr<void> feedInitialEvent(
      FeedInitialEvent event, Emitter<FeedState> emit) async {
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
  FutureOr<void> postCardInitialEvent(
      PostCardInitialEvent event, Emitter<FeedState> emit) async {
    // Check if the user has already voted on the post
    String res = await FeedMethods().checkPostVote(event.post.id!);
    if (res == "upvoted") {
      emit(PostUpvoteState(event.post.id!));
    } else if (res == "downvoted") {
      emit(PostDownvoteState(event.post.id!));
    }
  }

  FutureOr<void> postCardUpvoteEvent(
      PostCardUpvoteEvent event, Emitter<FeedState> emit) async {
    // Update the ui
    emit(PostUpvoteState(event.post.id!));
    String connectionStatus = await FeedMethods().checkInternetConnection();
    if (connectionStatus != "success") {
      emit(FeedErrorState(connectionStatus));
      return;
    }
    // Update firebase
    String res = await FeedMethods().upvotePost(event.post.id!);
    if (res != "success") {
      emit(FeedErrorState(res));
      return;
    }
  }

  FutureOr<void> postCardDownvoteEvent(
      PostCardDownvoteEvent event, Emitter<FeedState> emit) async {
    // Update the ui
    emit(PostDownvoteState(event.post.id!));
    String connectionStatus = await FeedMethods().checkInternetConnection();
    if (connectionStatus != "success") {
      emit(FeedErrorState(connectionStatus));
      return;
    }
    // Update firebase
    String res = await FeedMethods().downvotePost(event.post.id!);
    if (res != "success") {
      emit(FeedErrorState(res));
      return;
    }
  }

  FutureOr<void> postCardCancelUpvoteEvent(
      PostCardCancelUpvoteEvent event, Emitter<FeedState> emit) async {
    // Update the ui
    emit(PostCancelUpvoteState(event.post.id!, event.downVoted));
    String connectionStatus = await FeedMethods().checkInternetConnection();
    if (connectionStatus != "success") {
      emit(FeedErrorState(connectionStatus));
      return;
    }
    // Update firebase
    String res = await FeedMethods().cancelUpvotePost(event.post.id!);
    if (res != "success") {
      emit(FeedErrorState(res));
      return;
    }
    if (event.downVoted) {
      String res = await FeedMethods().downvotePost(event.post.id!);
      if (res != "success") {
        emit(FeedErrorState(res));
        return;
      }
    }
  }

  FutureOr<void> postCardCancelDownvoteEvent(
      PostCardCancelDownvoteEvent event, Emitter<FeedState> emit) async {
    emit(PostCancelDownvoteState(event.post.id!, event.upVoted));
    String connectionStatus = await FeedMethods().checkInternetConnection();
    if (connectionStatus != "success") {
      emit(FeedErrorState(connectionStatus));
      return;
    }
    // Update firebase
    String res = await FeedMethods().cancelDownvotePost(event.post.id!);
    if (res != "success") {
      emit(FeedErrorState(res));
      return;
    }
    // Update the ui
    if (event.upVoted) {
      String res = await FeedMethods().upvotePost(event.post.id!);
      if (res != "success") {
        emit(FeedErrorState(res));
        return;
      }
    }
  }

  FutureOr<void> postCardReportEvent(
      PostCardReportEvent event, Emitter<FeedState> emit) async {
    emit(PostReportPageActionState(post: event.post));
  }

  FutureOr<void> reportPostSubmitEvent(
      ReportPostSubmitEvent event, Emitter<FeedState> emit) async {
    emit(ReportPageLoadingState());
    String connectionStatus = await FeedMethods().checkInternetConnection();
    if (connectionStatus != "success") {
      emit(FeedErrorState(connectionStatus));
      emit(ReportPageInitial());
      return;
    }
    if (event.description.trim() == "") {
      emit(FeedErrorState("Please enter a description"));
      emit(ReportPageInitial());
      return;
    }
    String res = await FeedMethods().reportPost(event.postId, event.postUserId,
        event.userReportingId, event.description);
    if (res != "success") {
      emit(FeedErrorState(res));
      emit(ReportPageInitial());
      return;
    }
    emit(ReportPageSuccessState());
  }
}
