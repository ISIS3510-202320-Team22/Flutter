import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial()) {
    on<ChangeSwitchEvent>(changeSwitchEvent);
  }

  FutureOr<void> changeSwitchEvent(
      ChangeSwitchEvent event, Emitter<SettingsState> emit) {
    emit(ChangeSwitchState(switched: event.switched));
  }
}
