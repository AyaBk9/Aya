import 'package:flutter/material.dart';
import 'Register.dart';
import 'Game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Aya Project 2',
        home: Register());
  }
}
