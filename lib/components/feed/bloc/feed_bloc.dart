import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:guarap/components/feed/repository/posts_methods.dart';
import 'package:guarap/components/publish_photos/ui/publish_photo.dart';
import 'package:meta/meta.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FeedBloc() : super(FeedInitial()) {
    on<CategorySelectedEvent>(selectCategoryEvent);
  }

  FutureOr<void> selectCategoryEvent(
      CategorySelectedEvent event, Emitter<FeedState> emit) {
    emit(FeedLoadingState());
    PostMethods().uploadData(event.category);
    emit(CategorySelectedState(event.category));
  }
}
