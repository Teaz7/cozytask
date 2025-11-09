import 'package:cozytask/index.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue
      ),
      home: Scaffold(
        body: Center(
          child: const Index(),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}