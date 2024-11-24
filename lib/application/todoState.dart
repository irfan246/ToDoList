part of 'todoBloc.dart';

abstract class TodoState {
  List<Todo> get todos => [];
}

class TodoLoaded extends TodoState {
  final List<Todo> todos;

  TodoLoaded(this.todos);

  TodoLoaded copyWith({
    List<Todo>? todos,
  }) {
    return TodoLoaded(todos ?? this.todos);
  }

  @override
  List<Todo> get todo => this.todos;
}

class CategoryUpdateState extends TodoState {
  final String category;

  CategoryUpdateState(this.category);
}

class TodoInitial extends TodoState {}
