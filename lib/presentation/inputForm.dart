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

    return Scaffold(
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
            BlocBuilder<TodoBloc, TodoState>(
              builder: (context, state) {
                String selectedCategory = 'Income'; // Default category
                if (state is CategoryUpdateState) {
                  selectedCategory =
                      state.category; // If category updated by BLoC
                }

                return DropdownButtonFormField<String>(
                  value: selectedCategory,
                  items: ['Income', 'Spending'].map((category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      context
                          .read<TodoBloc>()
                          .add(UpdateCategory(category: value));
                    }
                  },
                  decoration: const InputDecoration(labelText: 'Category'),
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                final title = titleController.text;
                final price = priceController.text;
                final date = dateController.text;
                final category = 'Income';

                // Send AddTodo event to TodoBloc
                context.read<TodoBloc>().add(AddTodo(
                      title: title,
                      price: price,
                      date: date,
                      category: category,
                    ));

                Navigator.pop(context); // Go back to previous screen
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  String _getFormattedDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
