import 'package:flutter/material.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(40),
        ),
        
        Container(
          alignment: Alignment.center,
          child: Image.asset(
            'assets/COZY_TASK_LOGO.png',
            height: 150,
          ),
        ),

        Container(
          alignment: Alignment.center,
          child: Image.asset(
            'assets/COZY_TASK_TEXT_BLUE_LOGO.png',
            height: 80,
          ),
        ),
      ],
    );
  }
}