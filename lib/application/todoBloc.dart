import 'package:bloc/bloc.dart';
import 'todoModel.dart';

part 'todoEvent.dart';
part 'todoState.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    on<LoadTodosEvent>((event, emit) {
      emit(TodoLoaded([]));
    });

    on<AddTodo>((event, emit) {
      if (state is TodoLoaded) {
        final todos = List<Todo>.from((state as TodoLoaded).todos);
        todos.add(event.todos);
        emit(TodoLoaded(todos));
      }
    });

    on<EditTodo>((event, emit) {
      if (state is TodoLoaded) {
        final todos = (state as TodoLoaded).todos.map((todo) {
          return todo.id == event.id ? event.updateTodo : todo;
        }).toList();
        emit(TodoLoaded(todos));
      }
    });

    on<DeleteTodo>((event, emit) {
      if (state is TodoLoaded) {
        final todos = (state as TodoLoaded)
            .todos
            .where((todo) => todo.id != event.id)
            .toList();
        emit(TodoLoaded(todos));
      }
    });
  }
}
