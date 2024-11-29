import './routes/route.dart';
import './application/todoBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TodoBloc()..add(LoadTodosEvent()),
      child: MaterialApp(
        title: 'ToDo App',
        initialRoute: '/',
        onGenerateRoute: AppRouter().generateRoute,
      ),
    );
  }
}
