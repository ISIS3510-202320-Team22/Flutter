part of 'publish_bloc.dart';

@immutable
abstract class PublishEvent {}

class PublishInitialEvent extends PublishEvent {}

// Event when the add photo button is pressed
class AddPhotoButtonClickedEvent extends PublishEvent {
  AddPhotoButtonClickedEvent();
}

class PublishPostEvent extends PublishEvent {
  PublishPostEvent(this.date, this.description, this.category, this.image);
  final DateTime date;
  final String description;
  final String category;
  final File? image;
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
