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
  }

  FutureOr<void> _loginInitialEvent(
      LoginInitialEvent event, Emitter<AuthState> emit) {
    print("LoginInitialEvent");
  }

  FutureOr<void> loginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    print("LoginEvent");
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
}
