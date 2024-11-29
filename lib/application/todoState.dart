part of 'todoBloc.dart';

abstract class TodoState {}

class TodoLoaded extends TodoState {
  @override
  final List<Todo> todos;

  TodoLoaded(this.todos);
}

class TodoInitial extends TodoState {}
