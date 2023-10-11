import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guarap/components/publish_photos/bloc/publish_bloc.dart';
import 'package:image_picker/image_picker.dart';

class TakePhoto extends StatefulWidget {
  const TakePhoto({super.key});

  @override
  State<TakePhoto> createState() {
    return _TakePhotoState();
  }
}

class _TakePhotoState extends State<TakePhoto> {
  File? _pickedImageFile;
/*
  void _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxHeight: double.infinity,
        maxWidth: double.infinity);
    if (pickedImage == null) {
      return;
    }
    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });
  }
*/
  final PublishBloc publishBloc = PublishBloc();

  @override
  Widget build(context) {
    return BlocConsumer<PublishBloc, PublishState>(
        bloc: publishBloc,
        // Listen to events but doesnt render
        listenWhen: (previous, current) => current is PublishActionState,
        // Determines whether the builder should rebuild when the state changes
        buildWhen: (previous, current) => current is! PublishActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case AddToCirclePhotoState:
              final addToCirclePhotoState = state as AddToCirclePhotoState;
              _pickedImageFile = addToCirclePhotoState.pickedImage;
              break;
            default:
              _pickedImageFile = null;
          }
          return Column(
            children: [
              Container(
                width: 130, // Set your desired width
                height: 175, // Set your desired height
                decoration: BoxDecoration(
                  color: Colors.grey, // Set the background color
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: _pickedImageFile != null
                      ? Image.file(_pickedImageFile!)
                      : null,
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  //_pickImage();
                  publishBloc.add(AddPhotoButtonClickedEvent());
                },
                icon: const Icon(Icons.image),
                label: const Text(
                  "Add a photo",
                  style: TextStyle(color: Colors.grey),
                ),
              )
            ],
          );
        });
  }
}
