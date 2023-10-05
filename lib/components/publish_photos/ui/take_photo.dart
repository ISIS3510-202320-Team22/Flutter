import 'dart:io';

import 'package:flutter/material.dart';
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
  final PublishBloc publishBloc = PublishBloc();

  File? _pickedImageFile;

  void _pickImage() async {

  final pickedImage = await ImagePicker().pickImage(source:ImageSource.camera,imageQuality: 50,maxHeight: 400,maxWidth: 400);

  if(pickedImage == null){
    return;
  } 
  setState(() {
    _pickedImageFile = File(pickedImage.path);
  });
  }
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        CircleAvatar(
          radius: 80,
          backgroundColor: Colors.grey,
          foregroundImage: _pickedImageFile != null?  FileImage(_pickedImageFile!) : null,
        ),
        TextButton.icon(
          onPressed: () {
            _pickImage();
            // publishBloc.add(AddPhotoButtonClickedEvent());
          },
          icon: const Icon(Icons.image),
          label: const Text(
            "Add a photo",
            style: TextStyle(color: Colors.grey),
          ),
        )
      ],
    );
  }
}

  

