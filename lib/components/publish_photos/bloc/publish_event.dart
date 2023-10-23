part of 'publish_bloc.dart';

@immutable
abstract class PublishEvent {}

class PublishInitialEvent extends PublishEvent {}

// Event when the add photo button is pressed
class AddPhotoButtonClickedEvent extends PublishEvent {
  AddPhotoButtonClickedEvent();
}

class PublishDataEvent extends PublishEvent {
  PublishDataEvent(this.date, this.description, this.downvotes, this.upvotes,
      this.image, this.location, this.reported, this.uuid, this.category);
  final DateTime date;
  final String description;
  final int downvotes;
  final int upvotes;
  final File image;
  final String location;
  final bool reported;
  final String? uuid;
  final String? category;
  final String postId = const Uuid().v4();
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
