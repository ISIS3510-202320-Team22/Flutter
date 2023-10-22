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
      this.image, this.location, this.reported, this.user);
  final DateTime date;
  final String description;
  final int downvotes;
  final int upvotes;
  final File image;
  final String location;
  final bool reported;
  final String? user;
}
