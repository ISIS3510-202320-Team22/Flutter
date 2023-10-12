part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LoginInitialEvent extends AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

class RecoverAccountTextPressedEvent extends AuthEvent {
  final String email;

  RecoverAccountTextPressedEvent({required this.email});
}

class SignUpTextPressedEvent extends AuthEvent {}

// Recover Account Screen Events
class RecoverAccountInitialEvent extends AuthEvent {
  RecoverAccountInitialEvent();
}

class RecoverAccountEvent extends AuthEvent {
  final String email;
  RecoverAccountEvent({required this.email});
}

// Logout Events
class LogoutEvent extends AuthEvent {}
