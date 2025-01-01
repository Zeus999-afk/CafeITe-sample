import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

import 'screens/loginfirst.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(
              fontSize: 24.0,
            ), 
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
          ), 
        ),
        textTheme: TextTheme(
          headlineMedium: TextStyle( //headline1
            fontSize: 46.0,
            color: const Color.fromARGB(255, 25, 118, 210),
            fontWeight: FontWeight.w500,
          ),
          bodyMedium: const TextStyle(fontSize: 18.0), //bodyText1
        ),
      ),
      home: const LoginFirst(),
    );
  }
}