part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

class ChangeSwitchEvent extends SettingsEvent {
  ChangeSwitchEvent(this.switched);
  final bool switched;
}
