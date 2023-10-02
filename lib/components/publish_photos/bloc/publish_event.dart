part of 'publish_bloc.dart';

@immutable
abstract class PublishBlocEvent {}

// Event when the add photo button is pressed
class AddPhotoButtonClickedEvent extends PublishBlocEvent{

}

// Event to add the image to the circle

class AddPhotoButtonShowImageEvent extends PublishBlocEvent{

}