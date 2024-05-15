import 'package:flutter/material.dart';
import 'package:smart_eats/components/forms/login_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(254, 61, 18, 1),),
        useMaterial3: true,
      ),
      home: LoginForm(),
    );
  }
}