import './routes/route.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

  final route = RouteApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: route.onRoute,
    );
  }
}
