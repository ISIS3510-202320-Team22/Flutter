// import 'package:guarap/components/publish_photos/ui/publish_photos.dart';

part of 'publish_bloc.dart';

@immutable
abstract class PublishEvent {}

class PublishInitialEvent extends PublishEvent {}

// Event when the add photo button is pressed
class AddPhotoButtonClickedEvent extends PublishEvent {
  AddPhotoButtonClickedEvent();
}

class PublishPostEvent extends PublishEvent {
  PublishPostEvent(
      this.date, this.description, this.category, this.image, this.location);
  final Timestamp date;
  final String description;
  final String category;
  final File? image;
  String location = "";
  /*
  Map<String, dynamic> toJson() => {
        'date': date,
        'description': description,
        'downvotes': downvotes,
        'upvotes': upvotes,
        'image': image,
        'location': location,
        'reported': reported,
        'user': uuid,
      };
  */
}

class AddLocationEvent extends PublishEvent {}

class MapLocationEvent extends PublishEvent {
  MapLocationEvent(this.context);
  final BuildContext context;
}

class GoToFeedEvent extends PublishEvent {}

class CategorySelectedEvent extends PublishEvent {
  CategorySelectedEvent({required this.category});
  final String category;
}
