part of 'publish_bloc.dart';

@immutable
abstract class PublishState {}

abstract class PublishActionState extends PublishState{}

final class PublishInitial extends PublishState {}

// Action State to 
class AddToCirclePhotoActionState extends PublishActionState{

}