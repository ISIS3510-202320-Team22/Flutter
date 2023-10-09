import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:guarap/models/PhotosDataModel.dart';
import 'package:meta/meta.dart';

import '../../../data/photos_data.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    // On this event run a fuction to pass the state
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeProfileButtonClickedEvent>(homeProfileButtonClickedEvent);
    on<HomePublishButtonClickedEvent>(homePublishButtonClickedEvent);
    on<HomeProfileButtonNavigateEvent>(homeProfileButtonNavigateEvent);
    on<HomePublishButtonNavigateEvent>(homePublishButtonNavigateEvent);
  }

    FutureOr<void> homeInitialEvent(HomeInitialEvent event, Emitter<HomeState> emit) async{
      emit(HomeLoadingState());
      await Future.delayed(const Duration(seconds: 4));
      emit(HomeLoadedSuccessState(photos: PhotosData.dataList.map((e) => PhotoDataModel(e["id"],e["@username"],e["imageurl"])).toList()));
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
