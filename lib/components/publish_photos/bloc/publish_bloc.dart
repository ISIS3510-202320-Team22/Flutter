import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:guarap/components/publish_photos/repository/posts_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
part 'publish_event.dart';
part 'publish_state.dart';

class PublishBloc extends Bloc<PublishEvent, PublishState> {
  PublishBloc() : super(PublishInitial()) {
    on<AddPhotoButtonClickedEvent>(addPhotoButtonClickedEvent);
    on<PublishDataEvent>(publishDataEvent);
  }

  FutureOr<void> addPhotoButtonClickedEvent(
      AddPhotoButtonClickedEvent event, Emitter<PublishState> emit) async {
    final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxHeight: double.infinity,
        maxWidth: double.infinity);

    emit(AddToCirclePhotoState(pickedImage: File(pickedImage!.path)));
  }

  FutureOr<void> publishDataEvent(
      PublishDataEvent event, Emitter<PublishState> emit) async {
    final send = PostRepository().publishPost(
        event.date,
        event.description,
        event.downvotes,
        event.upvotes,
        event.image,
        event.location,
        event.reported,
        event.uuid,
        event.category);
    if (await send) {
      emit(PublishSuccessState());
    } else {
      emit(PublishErrorState());
    }
  }
}
