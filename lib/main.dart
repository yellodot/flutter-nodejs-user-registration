import 'package:flutter/material.dart';
import 'src/form_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assurly usecase',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const RegisterForm(),
    );
  }
}

