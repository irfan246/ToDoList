import '../application/todoBloc.dart';
import '../presentation/editScreen.dart';
import '../presentation/inputForm.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../presentation/homeScreen.dart';
import 'package:flutter/material.dart';

class RouteApp {
  Route onRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => TodoBloc(),
            child: HomeScreen(),
          ),
        );
      case '/add':
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => TodoBloc(),
            child: InputForm(),
          ),
        );
      case '/edit':
        final args = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => TodoBloc(),
            child: EditScreen(
              id: args['id']!,
              initialDate: args['date']!,
              initialTitle: args['title']!,
              initialPrice: args['price']!,
              initialCategory: args['category']!,
            ),
          ),
        );
      default:
        throw new ArgumentError('Invalid route name');
    }
  }
}
