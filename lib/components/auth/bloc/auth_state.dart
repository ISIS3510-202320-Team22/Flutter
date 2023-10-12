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

final class LoginNavigateToRecoverPageActionState extends AuthActionState {
  LoginNavigateToRecoverPageActionState();
}

final class LoginNavigateToSignUpPageActionState extends AuthActionState {}

// Recover Account Screen States
final class RecoverAccountInitialState extends AuthState {}

final class RecoverAccountAttemptState extends AuthState {}

final class RecoverAccountSuccessfulState extends AuthActionState {}

final class RecoverAccountFailureState extends AuthActionState {}

// Logout States
final class LogoutAttemptState extends AuthState {}

final class LogoutSuccessfulState extends AuthActionState {}

final class LogoutFailureState extends AuthActionState {}

