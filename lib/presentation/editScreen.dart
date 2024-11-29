import '../application/todoFormBloc.dart';
import '../application/todoModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../application/todoBloc.dart';

class EditScreen extends StatelessWidget {
  final Todo todo;

  EditScreen({
    required this.todo,
    super.key,
  });

  final TextEditingController dateController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleController.text = todo.title;
    priceController.text = todo.price;
    dateController.text = todo.date;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Todo'),
        centerTitle: true,
        backgroundColor: Colors.blue[200],
      ),
      body: BlocProvider(
        create: (_) => TodoFormBloc()..add(LoadTodoForm(todo: todo)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                controller: dateController,
                decoration: const InputDecoration(labelText: 'Date'),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    dateController.text =
                        '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
                  }
                },
              ),
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextFormField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              BlocBuilder<TodoFormBloc, TodoFormState>(
                builder: (context, state) => DropdownButton<String>(
                  value: state.category,
                  onChanged: (value) {
                    context
                        .read<TodoFormBloc>()
                        .add(CategoryChanged(category: value!));
                  },
                  items: ["Income", "Spending"]
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Delete ToDo"),
                          content: const Text(
                              "Are you sure you want to delete this ToDo?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () {
                                context
                                    .read<TodoBloc>()
                                    .add(DeleteTodo(id: todo.id));
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: const Text("Yes"),
                            ),
                          ],
                        ),
                      );
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text("Delete"),
                  ),
                  BlocBuilder<TodoFormBloc, TodoFormState>(
                    builder: (context, state) => ElevatedButton(
                      onPressed: () {
                        final updatedTodo = Todo(
                          id: todo.id,
                          title: titleController.text,
                          price: priceController.text,
                          category: state.category,
                          date: dateController.text,
                        );
                        context.read<TodoBloc>().add(
                            EditTodo(id: todo.id, updateTodo: updatedTodo));
                        Navigator.pop(context);
                      },
                      child: const Text("Confirm"),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
