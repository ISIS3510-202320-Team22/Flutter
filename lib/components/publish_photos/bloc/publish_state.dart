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
class PublishingDataState extends PublishActionState {}

class PublishSuccessState extends PublishActionState {}

class PublishErrorState extends PublishActionState {}
