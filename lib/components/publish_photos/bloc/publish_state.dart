part of 'publish_bloc.dart';

@immutable
abstract class PublishState {}

abstract class PublishActionState extends PublishState {}

final class PublishInitial extends PublishState {}

// Action State to add the taken photo
class AddToCirclePhotoState extends PublishState {
  AddToCirclePhotoState({required this.pickedImage});
  final File? pickedImage;
}

// Action State to publish the data
class PublishingPostState extends PublishActionState {}

class PublishSuccessState extends PublishActionState {}

class PublishErrorState extends PublishActionState {}

// Action State to show the photo submitted
class PublishPhotoSubmittedState extends PublishActionState {}

// Action State to show the photo not sbmitted
class PublishPhotoNotSubmittedState extends PublishActionState {}

class PublishPhotoErrorState extends PublishActionState {}

// STATES FOR THE LOCATION

class LoadingCircleState extends PublishState {}

class LocationSettedState extends PublishState {
  LocationSettedState({required this.location});
  final PhotoLocation location;
}
