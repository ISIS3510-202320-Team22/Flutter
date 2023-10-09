part of 'publish_bloc.dart';

@immutable
abstract class PublishBlocEvent {}

// Event when the add photo button is pressed
class AddPhotoButtonClickedEvent extends PublishBlocEvent {}
