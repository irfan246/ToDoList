import 'package:bloc/bloc.dart';
import 'todoModel.dart';

part 'todoEvent.dart';
part 'todoState.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  List<Todo> _todos = [];
  String _category = 'Income';

  TodoBloc() : super(TodoInitial()) {
    on<AddTodo>((event, emit) {
      final todo = Todo(
        id: DateTime.now().toString(),
        title: event.title,
        price: event.price,
        date: event.date,
        category: event.category,
      );
      _todos.add(todo);
      emit(TodoLoaded(_todos));
    });

    on<DeleteTodo>((event, emit) {
      _todos.removeWhere((todo) => todo.id == event.id);
      emit(TodoLoaded(_todos));
    });

    on<EditTodo>((event, emit) {
      final todoIndex = _todos.indexWhere((todo) => todo.id == event.id);
      if (todoIndex != -1) {
        _todos[todoIndex] = _todos[todoIndex].copyWith(
          title: event.newTitle,
          price: event.newPrice,
          date: event.newDate,
          category: event.newCategory,
        );
        emit(TodoLoaded(_todos));
      }
    });

    on<UpdateCategory>((event, emit) {
      _category = event.category;
      emit(CategoryUpdateState(_category));
    });
  }
}
