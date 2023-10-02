import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    // On this event run a fuction to pass the state
    on<HomeCameraButtonClickedEvent>(homeCameraButtonClickedEvent);
    on<HomePublishButtonClickedEvent>(homePublishButtonClickedEvent);
    on<HomeCameraButtonNavigateEvent>(homeCameraButtonNavigateEvent);
    on<HomePublishButtonNavigateEvent>(homePublishButtonNavigateEvent);
  }

  FutureOr<void> homeCameraButtonClickedEvent(
      HomeCameraButtonClickedEvent event, Emitter<HomeState> emit) {
        print("Vamosss Camera");
      }

  FutureOr<void> homePublishButtonClickedEvent(
      HomePublishButtonClickedEvent event, Emitter<HomeState> emit) {
          print("Vamosss Publish");
      }

  FutureOr<void> homeCameraButtonNavigateEvent(HomeCameraButtonNavigateEvent event, Emitter<HomeState> emit) {
      print("Vamosss Navigate Camera");
      // When I get this state, for performing an action
      emit(HomeNavigateToCameraPageActionState());
  }

  FutureOr<void> homePublishButtonNavigateEvent(HomePublishButtonNavigateEvent event, Emitter<HomeState> emit) {
      print("Vamosss Navigate Publish");
      emit(HomeNavigateToPublishPageActionState());
  }
}
