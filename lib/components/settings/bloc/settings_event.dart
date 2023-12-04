part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

class ChangeSwitchEvent extends SettingsEvent {
  ChangeSwitchEvent(this.switched);
  final bool switched;
}

class SettingsActionEvent extends SettingsEvent {
  SettingsActionEvent(
      this.title, this.description, this.context, this.isLoaded);
  final String title;
  final String description;
  final dynamic context;
  bool isLoaded;
}
