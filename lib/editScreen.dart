import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  final String initialDate;
  final String initialTitle;
  final String initialPrice;
  final String initialCategory;

  const EditScreen({
    required this.initialDate,
    required this.initialTitle,
    required this.initialPrice,
    required this.initialCategory,
    super.key,
  });

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final fromKey = GlobalKey<FormState>();
  late TextEditingController dateController;
  late TextEditingController titleController;
  late TextEditingController priceController;

  String? selectedCategory;
  final List<String> categories = ['Pemasukan', 'Pengeluaran'];

  @override
  void initState() {
    super.initState();
    dateController = TextEditingController(text: widget.initialDate);
    titleController = TextEditingController(text: widget.initialTitle);
    priceController = TextEditingController(text: widget.initialPrice);
    selectedCategory = widget.initialCategory;
  }

  @override
  void dispose() {
    dateController.dispose();
    titleController.dispose();
    priceController.dispose();
    super.dispose();
  }

  String _getFormattedDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        dateController.text = _getFormattedDate(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Edit Form",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue[200],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 40,
              left: 20,
              right: 20,
            ),
            child: Form(
              key: fromKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: dateController,
                    decoration: const InputDecoration(
                      labelText: 'Date',
                    ),
                    readOnly: true,
                    onTap: pickDate,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Date is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Enter Title',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Title is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Enter Price',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Price is required';
                      } else if (double.tryParse(value) == null) {
                        return 'Enter a valid number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: selectedCategory,
                    decoration: const InputDecoration(
                      labelText: 'Select Category',
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCategory = newValue;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Category is required';
                      }
                      return null;
                    },
                    items: categories
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Delete'),
                            content:
                                const Text('do you really want to delete it?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.pop(context, 'delete');
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        ),
                        child: const Text(
                          "Confirm Delete",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (fromKey.currentState!.validate()) {
                            final date = dateController.text;
                            final title = titleController.text;
                            final price = priceController.text;
                            final category = selectedCategory;

                            Navigator.pop(context, {
                              'date': date,
                              'title': title,
                              'price': price,
                              'category': category,
                            });
                          }
                        },
                        child: const Text(
                          "Confirm Edit",
                          style: TextStyle(color: Colors.blue),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
