part of 'feed_bloc.dart';

@immutable
abstract class FeedEvent {}

class FeedInitialEvent extends FeedEvent {}

class SelectCategoryEvent extends FeedEvent {
  SelectCategoryEvent(this.category);
  Category category;
}
