import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:guarap/components/publish_photos/model/location_model.dart';
import 'package:image_picker/image_picker.dart';
part 'publish_event.dart';
part 'publish_state.dart';

class PublishBloc extends Bloc<PublishEvent, PublishState> {
  PublishBloc() : super(PublishInitial()) {
    on<AddPhotoButtonClickedEvent>(addPhotoButtonClickedEvent);
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
}
