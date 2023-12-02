import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guarap/components/settings/bloc/settings_bloc.dart';

class Report extends StatefulWidget {
  Report({super.key, required this.settingsBloc});

  SettingsBloc settingsBloc = SettingsBloc();

  @override
  State<Report> createState() {
    return _Report();
  }
}

class _Report extends State<Report> {
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
              padding: const EdgeInsets.fromLTRB(25, 25, 25, 25),
              child: Column(
                children: [
                  Text(
                    "Report a problem or give feedback",
                    style: GoogleFonts.roboto(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ));
        });
  }
}
