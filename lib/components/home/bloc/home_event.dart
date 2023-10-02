part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

// Event when the camera button is clicked
class HomeProfileButtonClickedEvent extends HomeEvent{

}

// Event when the publish button is clicked
class HomePublishButtonClickedEvent extends HomeEvent{

}

// Event when the camera button is clicked to navigate to this page
class HomeProfileButtonNavigateEvent extends HomeEvent{


}

// Event when the publish button is clicked to navigate to this page
class HomePublishButtonNavigateEvent extends HomeEvent{

}