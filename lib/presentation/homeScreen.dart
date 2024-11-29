import 'package:catatan_keuangan/presentation/dataList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../application/todoBloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan Keuangan'),
        centerTitle: true,
        backgroundColor: Colors.blue[200],
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoaded) {
            return state.todos.isEmpty
                ? const Center(child: Text("No data."))
                : ListView.builder(
                    itemCount: state.todos.length,
                    itemBuilder: (context, index) {
                      final todo = state.todos[index];
                      return DataList(
                        title: todo.title,
                        price: 'Rp ${todo.price}',
                        date: todo.date,
                        cardColor: (todo.category == 'Income')
                            ? const Color(0xFFC8E6C9)
                            : const Color(0XFFFFCDD2),
                        onClick: () {
                          Navigator.pushNamed(context, '/edit',
                              arguments: todo);
                        },
                      );
                    },
                  );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        backgroundColor: Colors.blue[100],
        child: const Icon(Icons.add),
      ),
    );
  }
}
