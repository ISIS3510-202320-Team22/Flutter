import 'dart:async';

import 'package:bloc/bloc.dart';
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
    // TODO: Implement the logic to change the feed for the specific category
    emit(CategorySelectedState(event.category));
  }

  FutureOr<void> feedUpVoteEvent(
      FeedUpvoteEvent event, Emitter<FeedState> emit) {
    emit(FeedUpVoteState());
  }
}
