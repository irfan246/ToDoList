part of 'todoBloc.dart';

abstract class TodoEvent {}

class LoadTodosEvent extends TodoEvent {}

class AddTodo extends TodoEvent {
  final Todo todos;

  AddTodo({required this.todos});
}

class DeleteTodo extends TodoEvent {
  final String id;

  DeleteTodo({required this.id});
}

class EditTodo extends TodoEvent {
  final String id;
  final Todo updateTodo;

  EditTodo({required this.id, required this.updateTodo});
}
