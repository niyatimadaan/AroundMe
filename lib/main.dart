import 'package:flutter/material.dart';
import 'home_page.dart';
import 'list_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PayGo App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: HomePage(),
      routes: {
        '/list': (context) => ListScreen( street: '', locality: '',),
      },
    );
  }
}
