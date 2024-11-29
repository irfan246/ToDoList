import 'package:bloc/bloc.dart';
import 'todoModel.dart';

part 'todoFormEvent.dart';
part 'todoFormState.dart';

class TodoFormBloc extends Bloc<TodoFormEvent, TodoFormState> {
  TodoFormBloc() : super(TodoFormInitial()) {
    on<LoadTodoForm>((event, emit) {
      emit(TodoFormLoaded(event.todo.category));
    });

    on<CategoryChanged>((event, emit) {
      emit(TodoFormLoaded(event.category));
    });
  }
}
