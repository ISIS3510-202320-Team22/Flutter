import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    // On this event run a fuction to pass the state
    on<HomeProfileButtonClickedEvent>(homeProfileButtonClickedEvent);
    on<HomePublishButtonClickedEvent>(homePublishButtonClickedEvent);
    on<HomeProfileButtonNavigateEvent>(homeProfileButtonNavigateEvent);
    on<HomePublishButtonNavigateEvent>(homePublishButtonNavigateEvent);
  }

  FutureOr<void> homeProfileButtonClickedEvent(
      HomeProfileButtonClickedEvent event, Emitter<HomeState> emit) {
        print("Vamosss Profile");
      }

  FutureOr<void> homePublishButtonClickedEvent(
      HomePublishButtonClickedEvent event, Emitter<HomeState> emit) {
          print("Vamosss Publish");
      }

  FutureOr<void> homeProfileButtonNavigateEvent(HomeProfileButtonNavigateEvent event, Emitter<HomeState> emit) {
      print("Vamosss Navigate Profile");
      // When I get this state, for performing an action
      emit(HomeNavigateToProfilePageActionState());
  }

  FutureOr<void> homePublishButtonNavigateEvent(HomePublishButtonNavigateEvent event, Emitter<HomeState> emit) {
      print("Vamosss Navigate Publish");
      emit(HomeNavigateToPublishPageActionState());
  }
}
