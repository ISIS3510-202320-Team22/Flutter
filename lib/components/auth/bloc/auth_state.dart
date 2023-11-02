part of 'auth_bloc.dart';

@immutable
// Auth State is for UI changes
sealed class AuthState {}

// Auth Action State is for navigation or other small
// actions that don't require UI reload
sealed class AuthActionState extends AuthState {}

// Auth Initial State
class AuthInitial extends AuthState {}

// Login Screen States
final class LoginInitialState extends AuthState {}

final class LoginAttemptState extends AuthState {}

final class LoginSuccessfulState extends AuthActionState {}

final class LoginFailureState extends AuthActionState {}

// SignUp Screen States
final class SignUpInitialState extends AuthState {}

final class SignUpAttemptState extends AuthState {}

final class SignUpSuccessfulState extends AuthActionState {}

final class SignUpFailureState extends AuthActionState {
  final String errorMessage;
  SignUpFailureState({required this.errorMessage});
}

final class ValidatingState extends AuthState {}

// Recover Account Screen States
final class RecoverAccountInitialState extends AuthState {}

final class RecoverAccountAttemptState extends AuthState {}

final class RecoverAccountSuccessfulState extends AuthActionState {}

final class RecoverAccountFailureState extends AuthState {
  final String errorMessage;
  RecoverAccountFailureState({required this.errorMessage});
}

// Logout States
final class LogoutAttemptState extends AuthState {}

final class LogoutSuccessfulState extends AuthActionState {}

final class LogoutFailureState extends AuthActionState {}

// Navigation States
final class NavigateToLoginPageActionState extends AuthActionState {}

final class NavigateToRecoverPageActionState extends AuthActionState {}

final class NavigateToSignUpEmailPageActionState extends AuthActionState {}

final class NavigateToSignUpUsernamePageActionState extends AuthActionState {
  final String email;
  NavigateToSignUpUsernamePageActionState({required this.email});
}

final class NavigateToPasswordPageActionState extends AuthActionState {
  final String email;
  final String username;
  NavigateToPasswordPageActionState(
      {required this.email, required this.username});
}

final class NavigateToWelcomePageActionState extends AuthActionState {
  final String username;
  NavigateToWelcomePageActionState({required this.username});
}
