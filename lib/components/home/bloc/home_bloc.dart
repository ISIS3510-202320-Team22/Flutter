import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    // On this event run a fuction to pass the state
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeProfileButtonClickedEvent>(homeProfileButtonClickedEvent);
    on<HomePublishButtonClickedEvent>(homePublishButtonClickedEvent);
    on<HomeSettingsButtonNavigateEvent>(homeSettingsButtonNavigateEvent);
    on<HomeProfileButtonNavigateEvent>(homeProfileButtonNavigateEvent);
    on<HomePublishButtonNavigateEvent>(homePublishButtonNavigateEvent);
    on<HomeSortPostsButtonClickedEvent>(homeSortPostsButtonClickedEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    emit(HomeLoadedSuccessState());
  }

  FutureOr<void> homeProfileButtonClickedEvent(
      HomeProfileButtonClickedEvent event, Emitter<HomeState> emit) {}

  FutureOr<void> homePublishButtonClickedEvent(
      HomePublishButtonClickedEvent event, Emitter<HomeState> emit) {}

  FutureOr<void> homeProfileButtonNavigateEvent(
      HomeProfileButtonNavigateEvent event, Emitter<HomeState> emit) {
    // When I get this state, for performing an action
    emit(HomeNavigateToProfilePageActionState());
  }

  FutureOr<void> homePublishButtonNavigateEvent(
      HomePublishButtonNavigateEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToPublishPageActionState());
  }

  FutureOr<void> homeSettingsButtonNavigateEvent(
      HomeSettingsButtonNavigateEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToSettingsPageActionState());
  }

  FutureOr<void> homeSortPostsButtonClickedEvent(
      HomeSortPostsButtonClickedEvent event, Emitter<HomeState> emit) {
    String sortStrategy = event.currentStrategy;
    if (sortStrategy == "Recent") {
      sortStrategy = "Popular";
    } else {
      sortStrategy = "Recent";
    }
    emit(HomeSortStrategyChangedState(sortStrategy: sortStrategy));
  }
}
