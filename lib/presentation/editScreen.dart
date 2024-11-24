import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../application/todoBloc.dart';

class EditScreen extends StatelessWidget {
  final String id;
  final String initialDate;
  final String initialTitle;
  final String initialPrice;
  final String initialCategory;

  const EditScreen({
    required this.id,
    required this.initialDate,
    required this.initialTitle,
    required this.initialPrice,
    required this.initialCategory,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController dateController =
        TextEditingController(text: initialDate);
    final TextEditingController titleController =
        TextEditingController(text: initialTitle);
    final TextEditingController priceController =
        TextEditingController(text: initialPrice);

    String selectedCategory = initialCategory;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Todo'),
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
            BlocBuilder<TodoBloc, TodoState>(
              builder: (context, state) {
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
                      selectedCategory = value;
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

                context.read<TodoBloc>().add(EditTodo(
                      id: id,
                      newTitle: title,
                      newPrice: price,
                      newDate: date,
                      newCategory: selectedCategory,
                    ));

                Navigator.pop(context);
              },
              child: const Text('Submit Edit'),
            ),
          ],
        ),
      ),
    );
  }
}
