//992024008 - Nurmei Sarrah
//992024007 - Zilfany
//992024006 - Masyitah Nanda Yassril
//162022030 - Gilang Ramadhan

// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:cafeite/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'cafeITe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: 'home_page',
      routes: {
        'home_page': (context) => SplashScreen(),
        //'registration_screen': (context) => RegistrationScreen(),
        //'login_screen': (context) => LoginScreen(),
        //'home_screen': (context) => HomeScreen(),
        //'data_todo': (context) => DataTodo(),
        //'add_todo': (context) => AddTodo(),
        //'update_todo': (context) => UpdateTodo(),
      },
    );
  }
}
