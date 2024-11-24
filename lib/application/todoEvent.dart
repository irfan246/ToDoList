part of 'todoBloc.dart';

abstract class TodoEvent {}

class AddTodo extends TodoEvent {
  final String date;
  final String title;
  final String price;
  final String category;

  AddTodo({
    required this.title,
    required this.date,
    required this.price,
    required this.category,
  });
}

class DeleteTodo extends TodoEvent {
  final String id;

  DeleteTodo({required this.id});
}

class EditTodo extends TodoEvent {
  final String id;
  final String newTitle;
  final String newPrice;
  final String newDate;
  final String newCategory;

  EditTodo(
      {required this.id,
      required this.newTitle,
      required this.newPrice,
      required this.newDate,
      required this.newCategory});
}

class UpdateCategory extends TodoEvent {
  final String category;

  UpdateCategory({required this.category});
}
