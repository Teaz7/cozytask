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
          padding: EdgeInsets.all(60),
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
            height: 75,
          ),
        ),

        Padding(
          padding: EdgeInsets.all(35),
        ),

        Container(
          padding: EdgeInsets.all(0),
          width: 300,
          alignment: Alignment.centerLeft,
          child: Text(
            'Username or Email Address:',
            style: TextStyle(
              fontSize: 13
            ),
          ),
        ),

        Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          width: 300,
          height: 50,
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none
                )
              ),
              filled: true,
              fillColor: Color(0XFFD8E8F4)
            ),
            style: TextStyle(
              fontSize: 13
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.all(5),
        ),

        Container(
          padding: EdgeInsets.all(0),
          width: 300,
          alignment: Alignment.centerLeft,
          child: Text(
            'Password:',
            style: TextStyle(
              fontSize: 13
            ),
          ),
        ),

        Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          width: 300,
          height: 50,
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none
                )
              ),
              filled: true,
              fillColor: Color(0XFFD8E8F4)
            ),
            style: TextStyle(
              fontSize: 13,
            ),  
          ),
        ),
        
        Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          width: 300,
          alignment: Alignment.centerRight,
          child: Text(
            'Forgot Password?',
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: Color(0XFF898989),
              fontWeight: FontWeight.bold
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.all(15),
        ),

        ElevatedButton(
          onPressed: () {

          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(220, 40),
            backgroundColor: Color(0XFF68A3BC),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)
            )
          ),
          child: const Text(
            'LOGIN',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 21
              ),
            ),
        ),
        
        Padding(
          padding: EdgeInsets.all(5),
        ),

        ElevatedButton(
          onPressed: () {

          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(220, 40),
            backgroundColor: Color(0XFF68A3BC),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)
            )
          ),
          child: const Text(
            'ACCOUNTS',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 21
              ),
            ),
        ),

        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          width: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Don't have an account yet? ",
                style: TextStyle(
                  fontSize: 12
                ),
              ),
              
              Text(
                'Sign Up.',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}