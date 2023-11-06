import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:guarap/components/feed/repository/posts_methods.dart';
import 'package:meta/meta.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FeedBloc() : super(FeedInitial()) {
    on<CategorySelectedEvent>(selectCategoryEvent);
    on<FeedUpvoteEvent>(feedUpVoteEvent);
  }

  FutureOr<void> selectCategoryEvent(
      CategorySelectedEvent event, Emitter<FeedState> emit) {
    emit(FeedLoadingState());
    PostMethods().uploadData(event.category);
    emit(CategorySelectedState(event.category));
  }

  FutureOr<void> feedUpVoteEvent(
      FeedUpvoteEvent event, Emitter<FeedState> emit) {
    emit(FeedUpVoteState());
  }
}
