part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

// Event when the profile button is clicked
class HomeProfileButtonClickedEvent extends HomeEvent {}

// Event when the publish button is clicked
class HomePublishButtonClickedEvent extends HomeEvent {}

// Event when the categories button is clicked
class HomeCategoriesButtonClickedEvent extends HomeEvent {}

// Event when the profile button is clicked to navigate to this page
class HomeProfileButtonNavigateEvent extends HomeEvent {}

// Event when the publish button is clicked to navigate to this page
class HomePublishButtonNavigateEvent extends HomeEvent {}

// Event when the categories button is clicked to navigate to this page
class HomeCategoriesButtonNavigateEvent extends HomeEvent {}

// Event when the feed button is clicked to navigate to this page
class HomeFeedButtonNavigateEvent extends HomeEvent {}

// Event when the sort posts button is clicked
class HomeSortPostsButtonClickedEvent extends HomeEvent {
  final String currentStrategy;
  HomeSortPostsButtonClickedEvent({required this.currentStrategy});
}
