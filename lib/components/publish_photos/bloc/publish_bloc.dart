import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'publish_event.dart';
part 'publish_state.dart';

class PublishBloc extends Bloc<PublishBlocEvent, PublishState> {
  PublishBloc() : super(PublishInitial()) {
    on<AddPhotoButtonClickedEvent>(addPhotoButtonClickedEvent);
    on<AddPhotoButtonShowImageEvent>(addPhotoButtonShowImageEvent);
  }

  FutureOr<void> addPhotoButtonClickedEvent(AddPhotoButtonClickedEvent event, Emitter<PublishState> emit) {
    print("Gushh");
  }

  FutureOr<void> addPhotoButtonShowImageEvent(AddPhotoButtonShowImageEvent event, Emitter<PublishState> emit) {
        print("Gushh");
  }
}
