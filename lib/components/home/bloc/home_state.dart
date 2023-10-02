part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

// Actions our home may take, like navigation to other page in the UI
abstract class HomeActionState extends HomeState{}

class HomeInitial extends HomeState {}

// Leave some time to let the API calls bring the photos(despite we dont have backend yet to bring photos)
class HomeLoadingState extends HomeState{

}

// When the loading is done the actual app is going to appear
class HomeLoadedSuccessState extends HomeState{

}

// If an error ocurred
class HomeErrorState extends HomeState{

}

// Action State to navigate the camera view
class HomeNavigateToCameraPageActionState extends HomeActionState{

}

// Action State to navigate the publish view
class HomeNavigateToPublishPageActionState extends HomeActionState{
  
}
