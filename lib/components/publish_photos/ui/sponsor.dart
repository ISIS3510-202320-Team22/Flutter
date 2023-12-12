import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guarap/components/publish_photos/bloc/publish_bloc.dart';

class Sponsor extends StatefulWidget {
  Sponsor({super.key, required this.publishBloc});

  final PublishBloc publishBloc;
  @override
  State<Sponsor> createState() {
    return _Sponsor();
  }
}

class _Sponsor extends State<Sponsor> {
  File? _pickedImageSponsorFile;
  final _inputAmountControllerSponsor = TextEditingController();
  final _inputTextControllerSponsor = TextEditingController();
  bool _isLoadingSend = false;

  @override
  void dispose() {
    _inputAmountControllerSponsor.dispose();
    _inputTextControllerSponsor.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return BlocConsumer<PublishBloc, PublishState>(
        bloc: widget.publishBloc,
        listenWhen: (previous, current) => current is PublishActionState,
        buildWhen: (previous, current) => current is! PublishActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case AddToCircleSponsorPhotoState:
              final addToCircleSponsorPhotoState =
                  state as AddToCircleSponsorPhotoState;
              _pickedImageSponsorFile =
                  addToCircleSponsorPhotoState.pickedImageSponsor;
              break;
            case PublishingPostSponsorState:
              _isLoadingSend = true;
              break;
            default:
              _isLoadingSend = false;
          }

          return Scaffold(
              body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 25, 25, 25),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 130, // Set your desired width
                            height: 175, // Set your desired height
                            decoration: BoxDecoration(
                              color: Colors.grey, // Set the background color
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                              child: _pickedImageSponsorFile != null
                                  ? Image.file(_pickedImageSponsorFile!)
                                  : null,
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              widget.publishBloc
                                  .add(AddPhotoButtonClickedSponsorEvent());
                            },
                            icon: const Icon(Icons.image),
                            label: const Text(
                              "Add a photo",
                              style: TextStyle(color: Colors.grey),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _inputTextControllerSponsor,
                          // Max lenght for the user input
                          maxLength: 100,
                          decoration: InputDecoration(
                            hintText: "Type your message",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Enter an input value for the amount of money you want to sponsor
                      Expanded(
                        child: TextField(
                          controller: _inputAmountControllerSponsor,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Enter Value",
                            border: InputBorder.none,
                            hintStyle: GoogleFonts.roboto(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),

                      ElevatedButton(
                          onPressed: () {
                            if (_pickedImageSponsorFile == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Please add a photo!"),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            } else {
                              try {
                                widget.publishBloc.add(SendSponsorDataEvent(
                                    _pickedImageSponsorFile!,
                                    _inputTextControllerSponsor.text,
                                    int.parse(
                                      _inputAmountControllerSponsor.text,
                                    ),
                                    context));
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Please add a payment!"),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
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
                          child: !_isLoadingSend
                              ? Text(
                                  "Post Ad",
                                  style: GoogleFonts.roboto(
                                      color: Colors.white, fontSize: 18),
                                )
                              : const CircularProgressIndicator(
                                  color: Colors.white,
                                )),
                    ],
                  ),
                ],
              ),
            ),
          ));
        });
  }
}
