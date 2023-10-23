import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:guarap/components/auth/repository/auth_methods.dart';
import 'package:meta/meta.dart'; 

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginInitialEvent>(_loginInitialEvent);
    on<LoginEvent>(loginEvent);
    on<RecoverAccountTextPressedEvent>(recoverAccountTextPressedEvent);
    on<SignUpTextPressedEvent>(signUpTextPressedEvent);
    on<RecoverAccountInitialEvent>(recoverAccountInitialEvent);
    on<RecoverAccountEvent>(recoverAccountEvent);
    on<LogoutEvent>(logoutEvent);
  }

  // Login Screen Events
  FutureOr<void> _loginInitialEvent(
      LoginInitialEvent event, Emitter<AuthState> emit) {}

  FutureOr<void> loginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(LoginAttemptState());
    // Implement Login logic calling FirebaseAuth.dart
    // If successful, emit(LoginSuccessfulState());
    // If failed, emit(LoginFailureState());
    String res = await AuthMethods().loginUser(email: event.email, password: event.password);
    if (res == "success") {
      emit(LoginSuccessfulState());
    } else {
      emit(LoginFailureState());
      emit(LoginInitialState());
    }
  }

  FutureOr<void> recoverAccountTextPressedEvent(RecoverAccountTextPressedEvent event, Emitter<AuthState> emit) {
    emit(LoginNavigateToRecoverPageActionState());
  }

  FutureOr<void> signUpTextPressedEvent(SignUpTextPressedEvent event, Emitter<AuthState> emit) {
    emit(LoginNavigateToSignUpPageActionState());
  }

  // Recover Account Screen Events
  FutureOr<void> recoverAccountInitialEvent(RecoverAccountInitialEvent event, Emitter<AuthState> emit) {
    // TODO: implement passing the email from the login screen
  }

  FutureOr<void> recoverAccountEvent(RecoverAccountEvent event, Emitter<AuthState> emit) async {
    emit(RecoverAccountAttemptState());
    // Implement Recover Account logic calling FirebaseAuth.dart
    String res = await AuthMethods().recoverAccount(email: event.email);
    if (res == "success") {
      emit(RecoverAccountSuccessfulState());
    } else {
      emit(RecoverAccountFailureState(errorMessage: res));
    }
  }

  // Sign Up Screen Events
  FutureOr<void> signUpInitialEvent(SignUpInitialEvent event, Emitter<AuthState> emit) {}

  // Logout Events
  FutureOr<void> logoutEvent(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(LogoutAttemptState());
    String res = await AuthMethods().logoutUser();
    if (res == "success") {
      emit(LogoutSuccessfulState());
    } else {
      emit(LogoutFailureState());
    }
  }
}
