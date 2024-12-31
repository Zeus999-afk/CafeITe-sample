/*
  992024008 - Nurmei Sarrah
  992024007 - Zilfany
  992024006 - Masyitah Nanda Yassril
  162022030 - Gilang Ramadhan
  Deskripsi Kode: 
  Tanggal kode dibuat:
*/

import 'package:flutter/material.dart';

import 'package:cafeite/makanan/home.dart';

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
      home: const MakananList(),
      routes: {
        'list': (context) => const MakananList(),
        // 'form_add' : (context) => const ReminderFormAdd()
      },
    );
  }
}
