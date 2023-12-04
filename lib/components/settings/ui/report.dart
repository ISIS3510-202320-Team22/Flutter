import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guarap/components/settings/bloc/settings_bloc.dart';

class Report extends StatefulWidget {
  Report({super.key, required this.settingsBloc, required this.isLoaded});

  final SettingsBloc settingsBloc;
  bool isLoaded;

  @override
  State<Report> createState() {
    return _Report();
  }
}

class _Report extends State<Report> {
  final _inputTitleController = TextEditingController();
  final _inputDescriptionController = TextEditingController();

  @override
  void dispose() {
    _inputTitleController.dispose();
    _inputDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return BlocConsumer<SettingsBloc, SettingsState>(
        bloc: widget.settingsBloc,
        listenWhen: (previous, current) => current is SettingsActionState,
        buildWhen: (previous, current) => current is! SettingsActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case LoginAttemptSettingsState:
              widget.isLoaded = (state as LoginAttemptSettingsState).isLoaded;
              break;
          }

          return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 30),

                  Text(
                    "Report a bug or give feedback",
                    style: GoogleFonts.roboto(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),

                  Text(
                    'Title',
                    style: GoogleFonts.roboto(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Box input for the user to type the tilte description
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      maxLines: 3,
                      controller: _inputTitleController,
                      decoration: const InputDecoration(
                        hintText: "Title description",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    'Description',
                    style: GoogleFonts.roboto(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Box input for the user to type the feedback
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: _inputDescriptionController,
                      maxLines: 10,
                      decoration: const InputDecoration(
                        hintText: "Type your description here",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                  ),

                  // Button to send the feedback
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      bool loader = true;
                      widget.settingsBloc.add(SettingsActionEvent(
                          _inputTitleController.text,
                          _inputDescriptionController.text,
                          context,
                          loader));
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        color: Color(0xFFAB003E),
                      ),
                      child: !widget.isLoaded
                          ? Text(
                              "Send",
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            )
                          : const CircularProgressIndicator(
                              color: Colors.white,
                            ),
                    ),
                  )
                ],
              ));
        });
  }
}
