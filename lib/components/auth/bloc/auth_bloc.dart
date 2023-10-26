import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:guarap/components/auth/repository/auth_methods.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    // Login Events
    on<LoginInitialEvent>(_loginInitialEvent);
    on<LoginEvent>(loginEvent);

    // SignUp Events
    on<SignUpInitialEvent>(signUpInitialEvent);
    on<SignUpValidateEmailEvent>(signUpValidateEmailEvent);
    on<SignUpValidateUsernameEvent>(signUpValidateUsernameEvent);
    on<SignUpValidatePasswordEvent>(signUpValidatePasswordEvent);

    // Recover Account Events
    on<RecoverAccountTextPressedEvent>(recoverAccountTextPressedEvent);
    on<RecoverAccountInitialEvent>(recoverAccountInitialEvent);
    on<RecoverAccountEvent>(recoverAccountEvent);

    // Logout Events
    on<LogoutEvent>(logoutEvent);

    // Logout Events
    on<SignUpTextPressedEvent>(signUpTextPressedEvent);
  }

  // Login Screen Events
  FutureOr<void> _loginInitialEvent(
      LoginInitialEvent event, Emitter<AuthState> emit) {}

  FutureOr<void> loginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(LoginAttemptState());
    // Implement Login logic calling FirebaseAuth.dart
    // If successful, emit(LoginSuccessfulState());
    // If failed, emit(LoginFailureState());
    String res = await AuthMethods()
        .loginUser(email: event.email, password: event.password);
    if (res == "success") {
      emit(LoginSuccessfulState());
    } else {
      emit(LoginFailureState());
      emit(LoginInitialState());
    }
  }

  FutureOr<void> recoverAccountTextPressedEvent(
      RecoverAccountTextPressedEvent event, Emitter<AuthState> emit) {
    emit(NavigateToRecoverPageActionState());
  }

  FutureOr<void> signUpTextPressedEvent(
      SignUpTextPressedEvent event, Emitter<AuthState> emit) {
    emit(NavigateToSignUpEmailPageActionState());
  }

  // Recover Account Screen Events
  FutureOr<void> recoverAccountInitialEvent(
      RecoverAccountInitialEvent event, Emitter<AuthState> emit) {
    // TODO: implement passing the email from the login screen
  }

  FutureOr<void> recoverAccountEvent(
      RecoverAccountEvent event, Emitter<AuthState> emit) async {
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
  FutureOr<void> signUpInitialEvent(
      SignUpInitialEvent event, Emitter<AuthState> emit) {
    emit(SignUpInitialState());
  }

  FutureOr<void> signUpValidateEmailEvent(
      SignUpValidateEmailEvent event, Emitter<AuthState> emit) async {
    emit(ValidatingState());
    // Validate email to be @uniandes.edu.co only
    if (event.email.endsWith("@uniandes.edu.co")) {
      // Wait 1 second
      await Future.delayed(const Duration(seconds: 1));
      emit(SignUpInitialState());
      emit(NavigateToSignUpUsernamePageActionState(email: event.email));
    } else {
      emit(SignUpFailureState(
          errorMessage:
              'Email address must be from a @uniandes.edu.co domain'));
      emit(SignUpInitialState());
    }
  }

  FutureOr<void> signUpValidateUsernameEvent(
      SignUpValidateUsernameEvent event, Emitter<AuthState> emit) async {
    emit(ValidatingState());
    await Future.delayed(const Duration(seconds: 1));
    emit(SignUpInitialState());
    emit(NavigateToPasswordPageActionState(
        email: event.email, username: event.username));
  }

  FutureOr<void> signUpValidatePasswordEvent(
      SignUpValidatePasswordEvent event, Emitter<AuthState> emit) async {
    emit(ValidatingState());
    if (event.password.length < 6) {
      emit(SignUpFailureState(
          errorMessage: "Password must have 6 characters at least"));
      emit(SignUpInitialState());
    } else {
      String res = await AuthMethods().createUser(
          email: event.email,
          username: event.username,
          password: event.password);
      if (res == "success") {
        await Future.delayed(const Duration(seconds: 1));
        emit(SignUpInitialState());
        emit(NavigateToWelcomePageActionState(username: event.username));
        await Future.delayed(const Duration(seconds: 4));
        emit(SignUpSuccessfulState());
      } else {
        emit(SignUpFailureState(errorMessage: res));
        emit(SignUpInitialState());
      }
    }
  }

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
