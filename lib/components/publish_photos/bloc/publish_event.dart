// import 'package:guarap/components/publish_photos/ui/publish_photos.dart';

part of 'publish_bloc.dart';

@immutable
abstract class PublishEvent {}

class PublishInitialEvent extends PublishEvent {}

// Event when the add photo button is pressed
class AddPhotoButtonClickedEvent extends PublishEvent {
  // AddPhotoButtonClickedEvent();
}

class PublishPostEvent extends PublishEvent {
  PublishPostEvent(
      this.date, this.description, this.category, this.image, this.location);
  final Timestamp date;
  final String description;
  final String category;
  final File? image;
  String location = "";
}

class AddLocationEvent extends PublishEvent {}

class MapLocationEvent extends PublishEvent {
  MapLocationEvent(this.context, this.publishBloc);
  final BuildContext context;
  final PublishBloc publishBloc;
}

class GoToFeedEvent extends PublishEvent {}

class CategorySelectedEvent extends PublishEvent {
  CategorySelectedEvent({required this.category});
  final Category category;
}

class LocationSelectedEvent extends PublishEvent {
  LocationSelectedEvent({required this.location});
  final String location;
}

class NearbyLocationsEvent extends PublishEvent {
  NearbyLocationsEvent({required this.currentLocation});
  final LatLng currentLocation;
}
