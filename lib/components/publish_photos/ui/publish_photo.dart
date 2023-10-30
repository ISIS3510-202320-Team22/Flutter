import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guarap/components/publish_photos/bloc/publish_bloc.dart';
import 'package:guarap/components/publish_photos/ui/add_location.dart';
import 'package:guarap/components/publish_photos/ui/take_photo.dart';
import 'package:intl/intl.dart';

enum Category { Generic, Chismes, Atardeceres, LookingFor, Emprendimientos }

class PublishPhoto extends StatefulWidget {
  PublishPhoto({super.key});

  File? _pickedImageFile;
  String? address;

  @override
  State<PublishPhoto> createState() {
    return _PublishPhotoState();
  }
}

class _PublishPhotoState extends State<PublishPhoto> {
  Category _selectedCategory = Category.Generic;
  final _inputTextController = TextEditingController();
  final PublishBloc publishBloc = PublishBloc();
  final Timestamp actualDate =
      Timestamp(DateTime.now().year, DateTime.now().month);
  var _isLoading = false;
  @override
  void dispose() {
    _inputTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return BlocConsumer<PublishBloc, PublishState>(
      bloc: publishBloc,
      listenWhen: (previous, current) => current is PublishActionState,
      buildWhen: (previous, current) => current is! PublishActionState,
      listener: (context, state) {
        if (state is PublishSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Posted!"),
              backgroundColor: Colors.blue,
            ),
          );
        } else if (state is PublishErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Error, post not published!"),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is PublishPhotoErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Error: Could not send photo. Try again later!"),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case AddToCirclePhotoState:
            final addToCirclePhotoState = state as AddToCirclePhotoState;
            widget._pickedImageFile = addToCirclePhotoState.pickedImage;
            break;
          case LocationSettedState:
            final locationSettedState = state as LocationSettedState;
            widget.address = locationSettedState.location.address;
            break;
          case PublishSuccessState:
            _isLoading = true;
            break;
        }
        return Scaffold(
            appBar: AppBar(
              title: Text(
                "New Post",
                style: GoogleFonts.roboto(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 25, 25, 25),
                child: Column(
                  children: [
                    _isLoading
                        ? const Center(
                            child: LinearProgressIndicator(),
                          )
                        : const SizedBox.shrink(),
                    // First row for image post and the input field
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TakePhoto(publishBloc: publishBloc),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _inputTextController,
                            // Max lenght for the user input
                            maxLength: 100,
                            decoration: InputDecoration(
                              hintText: "Write a caption...",
                              border: InputBorder.none,
                              // text styling
                              hintStyle: GoogleFonts.roboto(
                                color: Colors.grey,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Second row for the Category Tags
                    Container(
                      // Give some padding to inner elements
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      // Container border but only the top and bottom
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 1.0, color: Colors.grey),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                hintText: "Category Tags",
                                border: InputBorder.none,
                                // text styling
                                hintStyle: GoogleFonts.roboto(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                            child: DropdownButton(
                              isExpanded: true,
                              value: _selectedCategory,
                              items: Category.values
                                  .map((category) => DropdownMenuItem(
                                      value: category,
                                      child: Text(category.name)))
                                  .toList(),
                              onChanged: (value) {
                                if (value == null) return;
                                setState(() {
                                  _selectedCategory = value;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    //Third row for the location of the user
                    AddLocation(publishBloc: publishBloc),

                    const SizedBox(height: 30),

                    // Fifth row for the Publish button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (widget._pickedImageFile == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Please add a photo!"),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            } else {
                              publishBloc.add(PublishPostEvent(
                                  actualDate,
                                  _inputTextController.text,
                                  _selectedCategory.name,
                                  widget._pickedImageFile!,
                                  widget.address));
                            }
                          },

                          // red color button and text white
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 171, 0, 72),
                            foregroundColor: Colors.white,
                            // Expand button width
                            minimumSize: const Size(250, 30),
                          ),
                          child: const Text("Share",
                              style: TextStyle(fontSize: 20)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
