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
    if (event.email.trim() == "") {
      emit(SignUpFailureState(errorMessage: "Email address cannot be empty"));
      emit(SignUpInitialState());
    } else if (event.email.trim() != event.email) {
      emit(SignUpFailureState(
          errorMessage: "Email address cannot start or end with whitespaces"));
      emit(SignUpInitialState());
    }
    // Check if the email has at least 1 character before the @
    else if (event.email.split("@")[0].trim().isEmpty) {
      emit(SignUpFailureState(errorMessage: "Email address must be valid"));
      emit(SignUpInitialState());
    }
    // Validate email to be @uniandes.edu.co only
    else if (!event.email.endsWith("@uniandes.edu.co")) {
      emit(SignUpFailureState(
          errorMessage:
              'Email address must be from a @uniandes.edu.co domain'));
      emit(SignUpInitialState());
    } else {
      // Verify the email is not already in use
      String res = await AuthMethods().checkEmail(email: event.email);
      if (res == "success") {
        emit(SignUpInitialState());
        emit(NavigateToSignUpUsernamePageActionState(email: event.email));
      } else {
        emit(SignUpFailureState(errorMessage: res));
        emit(SignUpInitialState());
      }
    }
  }

  FutureOr<void> signUpValidateUsernameEvent(
      SignUpValidateUsernameEvent event, Emitter<AuthState> emit) async {
    emit(ValidatingState());
    if (event.username.trim() == "") {
      emit(SignUpFailureState(
          errorMessage: "Username cannot have only whitespaces"));
      emit(SignUpInitialState());
    } else if (event.username.trim() != event.username) {
      emit(SignUpFailureState(
          errorMessage: "Username cannot start or end with whitespaces"));
      emit(SignUpInitialState());
    } else if (event.username.trim().length < 5) {
      emit(SignUpFailureState(
          errorMessage: "Username must have 5 characters at least"));
      emit(SignUpInitialState());
    } else if (event.username.trim().length > 20) {
      emit(SignUpFailureState(
          errorMessage: "Username must have 20 characters at most"));
      emit(SignUpInitialState());
    } else {
      String res = await AuthMethods().checkUsername(username: event.username);
      if (res == "success") {
        emit(SignUpInitialState());
        emit(NavigateToPasswordPageActionState(
            email: event.email, username: event.username));
      } else {
        emit(SignUpFailureState(errorMessage: res));
        emit(SignUpInitialState());
      }
    }
  }

  FutureOr<void> signUpValidatePasswordEvent(
      SignUpValidatePasswordEvent event, Emitter<AuthState> emit) async {
    emit(ValidatingState());
    if (event.password.trim() == "") {
      emit(SignUpFailureState(
          errorMessage: "Password cannot have only whitespaces"));
      emit(SignUpInitialState());
    }
    // Check if the password starts or ends with whitespaces
    else if (event.password.trim() != event.password) {
      emit(SignUpFailureState(
          errorMessage: "Password cannot start or end with whitespaces"));
      emit(SignUpInitialState());
    } else if (event.password.trim().length < 7) {
      emit(SignUpFailureState(
          errorMessage: "Password must have 7 characters at least"));
      emit(SignUpInitialState());
    } else if (event.password.trim().length > 64) {
      emit(SignUpFailureState(
          errorMessage: "Password must have 64 characters at most"));
      emit(SignUpInitialState());
    } else {
      String res = await AuthMethods().createUser(
          email: event.email,
          username: event.username,
          password: event.password);
      if (res == "success") {
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
