import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:smart_eats/components/forms/login_form.dart';
import 'package:smart_eats/contexts/user_context.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => UserContext()),
    ],
      child:   const MyApp(),
    )

  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromRGBO(254, 61, 18, 1),
        ),
        useMaterial3: true,
      ),
      home: LoginForm(
      ),
    );
  }
}
