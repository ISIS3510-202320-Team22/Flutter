import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guarap/components/settings/bloc/settings_bloc.dart';
import 'package:guarap/components/settings/ui/report.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() {
    return _Settings();
  }
}

class _Settings extends State<Settings> {
  bool isSwitch = false;
  final SettingsBloc settingsBloc = SettingsBloc();
  bool isLoaded = false;
  @override
  Widget build(context) {
    return BlocConsumer<SettingsBloc, SettingsState>(
        bloc: settingsBloc,
        listenWhen: (previous, current) => current is SettingsActionState,
        buildWhen: (previous, current) => current is! SettingsActionState,
        listener: (context, state) {
          switch (state.runtimeType) {
            case PublishSuccessSettingsState:
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Report sent successfully",
                    style: GoogleFonts.roboto(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: Colors.blue,
                ),
              );
              break;

            case NoInternetErrorActionSponsorState:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      "Error: No internet connection! Please try again later."),
                  backgroundColor: Colors.yellow,
                ),
              );
              break;

            case PublishErrorSettingsState:
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Error uploading report. Please try again later.",
                    style: GoogleFonts.roboto(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
              );
              break;
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case ChangeSwitchState:
              final changeSwitchState = state as ChangeSwitchState;
              isSwitch = changeSwitchState.switched;
              break;
          }

          return Scaffold(
              appBar: AppBar(
                title: Text(
                  "Settings",
                  style: GoogleFonts.arima(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
              ),
              resizeToAvoidBottomInset: true,
              body: Column(
                children: [
                  const SizedBox(height: 32.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Notifications",
                        style: GoogleFonts.roboto(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          fontSize: 20,
                        ),
                      ),
                      Switch(
                          value: isSwitch,
                          onChanged: (value) {
                            isSwitch = value;
                            settingsBloc.add(ChangeSwitchEvent(isSwitch));
                          })
                    ],
                  ),
                  const SizedBox(height: 32.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "About us",
                        style: GoogleFonts.roboto(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          fontSize: 20,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward_ios),
                        onPressed: () {},
                      )
                    ],
                  ),
                  const SizedBox(height: 32.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Report a bug or issue",
                        style: GoogleFonts.roboto(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          fontSize: 20,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward_ios),
                        onPressed: () {
                          showModalBottomSheet(
                              enableDrag: true,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20.0)),
                              ),
                              context: context,
                              builder: (context) => Report(
                                  settingsBloc: settingsBloc,
                                  isLoaded: isLoaded));
                        },
                      )
                    ],
                  ),
                ],
              ));
        });
  }
}
