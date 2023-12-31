part of 'settings_bloc.dart';

@immutable
sealed class SettingsState {}

abstract class SettingsActionState extends SettingsState {}

final class SettingsInitial extends SettingsState {}

final class ChangeSwitchState extends SettingsState {
  ChangeSwitchState({required this.switched});

  final bool switched;
}

class PublishSuccessSettingsState extends SettingsActionState {}

class PublishErrorSettingsState extends SettingsActionState {
  PublishErrorSettingsState({required this.errorMessage});

  final String errorMessage;
}

class NoInternetErrorActionSponsorState extends SettingsActionState {}

class SendReportAttemptState extends SettingsState {}
