import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:guarap/components/publish_photos/ui/publish_photo.dart';
import 'package:meta/meta.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FeedBloc() : super(FeedInitial()) {
    on<SelectCategoryEvent>(selectCategoryEvent);
  }

  FutureOr<void> selectCategoryEvent(
      SelectCategoryEvent event, Emitter<FeedState> emit) {
    emit(CategorySelectedState());
  }
}
