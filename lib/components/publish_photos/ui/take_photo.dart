import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guarap/components/publish_photos/bloc/publish_bloc.dart';

class TakePhoto extends StatefulWidget {
  const TakePhoto({super.key, required this.publishBloc});
  final PublishBloc publishBloc;
  @override
  State<TakePhoto> createState() {
    return _TakePhotoState();
  }
}

class _TakePhotoState extends State<TakePhoto> {
  File? _pickedImageFile;
  @override
  Widget build(context) {
    return BlocConsumer<PublishBloc, PublishState>(
        bloc: widget.publishBloc,
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
                  widget.publishBloc.add(AddPhotoButtonClickedEvent());
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
