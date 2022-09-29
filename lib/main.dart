import 'package:flutter/material.dart';
import 'package:usecase_assurly/src/back_office_page.dart';
import 'src/signup_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const RegisterForm(),
        '/admin': (context) => const Home(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
