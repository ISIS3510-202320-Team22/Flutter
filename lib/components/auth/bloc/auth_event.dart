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

// SignUp Screen Events
class SignUpInitialEvent extends AuthEvent {}

class SignUpValidateEmailEvent extends AuthEvent {
  final String email;
  SignUpValidateEmailEvent({required this.email});
}

class SignUpValidateUsernameEvent extends AuthEvent {
  final String email;
  final String username;
  SignUpValidateUsernameEvent({required this.email, required this.username});
}

class SignUpValidatePasswordEvent extends AuthEvent {
  final String email;
  final String username;
  final String password;
  SignUpValidatePasswordEvent(
      {required this.email, required this.username, required this.password});
}

// Logout Events
class LogoutEvent extends AuthEvent {}
