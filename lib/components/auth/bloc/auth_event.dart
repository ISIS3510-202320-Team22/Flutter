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
class SignUpInitialEvent extends AuthEvent {
  SignUpInitialEvent();
}



class SignUpEvent extends AuthEvent {
  final String email;
  final String password;
  final String confirmPassword;
  SignUpEvent(
      {required this.email,
      required this.password,
      required this.confirmPassword});
}

// Logout Events
class LogoutEvent extends AuthEvent {}
