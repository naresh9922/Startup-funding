import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_idea_event.dart';
part 'create_idea_state.dart';

class CreateIdeaBloc extends Bloc<CreateIdeaEvent, CreateIdeaState> {
  CreateIdeaBloc() : super(CreateIdeaInitial()) {
    on<CreateIdeaEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
