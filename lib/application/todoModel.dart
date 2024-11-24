class Todo {
  final String id;
  final String date;
  final String title;
  final String price;
  final String category;

  Todo(
      {required this.id,
      required this.date,
      required this.title,
      required this.price,
      required this.category});

  Todo copyWith(
      {String? id,
      String? title,
      String? price,
      String? category,
      String? date}) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      price: price ?? this.price,
      category: category ?? this.category,
    );
  }
}
