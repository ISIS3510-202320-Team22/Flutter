part of 'feed_bloc.dart';

@immutable
abstract class FeedEvent {}

class FeedInitialEvent extends FeedEvent {}

class CategorySelectedEvent extends FeedEvent {
  final String category;

  CategorySelectedEvent({required this.category});
}
