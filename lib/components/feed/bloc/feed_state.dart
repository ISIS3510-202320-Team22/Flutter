part of 'feed_bloc.dart';

@immutable
sealed class FeedState {}

abstract class FeedActionState extends FeedState {}

final class FeedInitial extends FeedState {}

class CategorySelectedState extends FeedActionState {}
