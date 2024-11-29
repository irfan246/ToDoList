import 'package:catatan_keuangan/presentation/editScreen.dart';
import 'package:catatan_keuangan/presentation/homeScreen.dart';
import 'package:catatan_keuangan/presentation/inputForm.dart';
import 'package:flutter/material.dart';
import '../application/todoModel.dart';

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/add':
        return MaterialPageRoute(builder: (_) => const InputForm());
      case '/edit':
        if (settings.arguments is Todo) {
          final todo = settings.arguments as Todo;
          return MaterialPageRoute(builder: (_) => EditScreen(todo: todo));
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text("Error")),
        body: const Center(child: Text("Page not found!")),
      ),
    );
  }
}
