part of 'todoFormBloc.dart';

abstract class TodoFormState {
  final String category;

  const TodoFormState({required this.category});
}

class TodoFormLoaded extends TodoFormState {
  @override
  final String category;

  TodoFormLoaded(this.category)
      : super(
          category: category,
        );
}

class TodoFormInitial extends TodoFormState {
  TodoFormInitial({
    super.category = "Income",
  });
}
