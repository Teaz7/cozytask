import 'package:cozytask/main.dart';
import 'package:flutter/material.dart';

class ReturnLoginButton extends StatefulWidget {
  const ReturnLoginButton({super.key});

  @override
  State<ReturnLoginButton> createState() => _ReturnLoginButtonState();
}

class _ReturnLoginButtonState extends State<ReturnLoginButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 60),
        
        SizedBox(
          width: 350,
          child: Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage()),
                );
              },
              child: Image.asset(
                'assets/icon/BackButton.png',
                height: 30,
                alignment: Alignment.centerLeft,
              ),
            ),
          )
        )
      ],
    );
  }
}