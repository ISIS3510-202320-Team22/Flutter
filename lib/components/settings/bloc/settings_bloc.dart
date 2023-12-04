import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:guarap/components/settings/repository/settings_methods.dart';
import 'package:meta/meta.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial()) {
    on<ChangeSwitchEvent>(changeSwitchEvent);
    on<SettingsActionEvent>(settingsActionEvent);
  }

  FutureOr<void> changeSwitchEvent(
      ChangeSwitchEvent event, Emitter<SettingsState> emit) {
    emit(ChangeSwitchState(switched: event.switched));
  }

  FutureOr<void> settingsActionEvent(
      SettingsActionEvent event, Emitter<SettingsState> emit) async {
    bool isLoaded = event.isLoaded;

    emit(LoginAttemptSettingsState(isLoaded));

    String internetConnection =
        await SettingsMethods().checkInternetConnection();
    if (internetConnection != "success") {
      emit(NoInternetErrorActionState());
      //emit(PublishInitial());
      return;
    }
    final res = await SettingsMethods()
        .publishReportBug(event.title, event.description);
    if (res == "success") {
      emit(PublishSuccessSettingsState());
      Navigator.pop(event.context);
    } else {
      emit(PublishErrorSettingsState(errorMessage: res));
      //emit(PublishInitial());
    }
  }
}
