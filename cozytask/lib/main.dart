import 'package:cozytask/login.dart';
import 'package:cozytask/chooseaccount.dart';
import 'package:cozytask/signup.dart';
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
        primarySwatch: Colors.blue,
        fontFamily: 'GillSansMT'
      ),
      home: Scaffold(
        body: Center(
          child: const Login(),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}