import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guarap/components/settings/bloc/settings_bloc.dart';

class Report extends StatefulWidget {
  Report({super.key, required this.settingsBloc});

  final SettingsBloc settingsBloc;
  @override
  State<Report> createState() {
    return _Report();
  }
}

class _Report extends State<Report> {
  final _inputTitleController = TextEditingController();
  final _inputDescriptionController = TextEditingController();

  @override
  Widget build(context) {
    return BlocConsumer<SettingsBloc, SettingsState>(
        bloc: widget.settingsBloc,
        listenWhen: (previous, current) => current is SettingsActionState,
        buildWhen: (previous, current) => current is! SettingsActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {}

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
                  ElevatedButton(
                    onPressed: () {
                      widget.settingsBloc.add(SettingsActionEvent(
                          _inputTitleController.text,
                          _inputDescriptionController.text,
                          context));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Send",
                      style: GoogleFonts.roboto(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ));
        });
  }
}
