part of 'todoFormBloc.dart';

abstract class TodoFormEvent {}

class LoadTodoForm extends TodoFormEvent {
  final Todo todo;

  LoadTodoForm({required this.todo});
}

class CategoryChanged extends TodoFormEvent {
  final String category;

  CategoryChanged({required this.category});
}
