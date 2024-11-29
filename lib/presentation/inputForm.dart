import 'package:catatan_keuangan/application/todoFormBloc.dart';

import '../application/todoFormBloc.dart';
import '../application/todoModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../application/todoBloc.dart';

class InputForm extends StatelessWidget {
  const InputForm({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final TextEditingController dateController = TextEditingController();
    dateController.text = _getFormattedDate(DateTime.now());

    return BlocProvider(
      create: (_) => TodoFormBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('New Form'),
          centerTitle: true,
          backgroundColor: Colors.blue[200],
        ),
        body: Padding(
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
                    dateController.text = _getFormattedDate(pickedDate);
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
              BlocBuilder<TodoFormBloc, TodoFormState>(
                builder: (context, state) => ElevatedButton(
                  onPressed: () {
                    final todo = Todo(
                      id: DateTime.now().toString(),
                      title: titleController.text,
                      price: priceController.text,
                      category: state.category,
                      date: dateController.text,
                    );
                    context.read<TodoBloc>().add(AddTodo(todos: todo));
                    Navigator.pop(context);
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getFormattedDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
