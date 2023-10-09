part of 'auth_bloc.dart';

@immutable
// Auth State is for UI changes
sealed class AuthState {}

// Auth Action State is for navigation or other small
// actions that don't require UI reload
sealed class AuthActionState extends AuthState {}

// Auth Initial State
class AuthInitial extends AuthState {}

final class LoginInitialState extends AuthState {}

final class LoginAttemptState extends AuthState {}

final class LoginSuccessfulState extends AuthActionState {}

final class LoginFailureState extends AuthActionState {}

final class LoginNavigateToRecoverPageActionState extends AuthActionState {}

final class LoginNavigateToSignUpPageActionState extends AuthActionState {}
