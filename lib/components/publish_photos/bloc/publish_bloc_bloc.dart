import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'publish_bloc_event.dart';
part 'publish_bloc_state.dart';

class PublishBlocBloc extends Bloc<PublishBlocEvent, PublishBlocState> {
  PublishBlocBloc() : super(PublishBlocInitial()) {
    on<PublishBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
