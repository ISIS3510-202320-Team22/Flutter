part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

class ChangeSwitchEvent extends SettingsEvent {
  ChangeSwitchEvent(this.switched);
  final bool switched;
}

class SettingsActionEvent extends SettingsEvent {
  SettingsActionEvent(this.title, this.description, this.context);
  final String title;
  final String description;
  final dynamic context;
}

class AboutUsEvent extends SettingsEvent {
  AboutUsEvent(this.context);
  final dynamic context;
}
