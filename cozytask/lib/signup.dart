import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    List<String> fields = ['Username:', 'Email Address:', 'University:', 'Year Level:', 'Password:', 'Confirm Password:'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(45),
        ),

        Container(
          alignment: Alignment.center,
          child: Image.asset(
            'assets/img/COZY_TASK_TEXT_BLUE_LOGO.png',  
            height: 75,
          ),
        ),

        Padding(
          padding: EdgeInsets.all(25),
        ),

        Container(
          padding: EdgeInsets.all(0),
          width: 300,
          alignment: Alignment.center,
          child: Text(
            'CREATE AN ACCOUNT',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0XFF68A3BC)
            ),
          ),
        ),

        //for loop here -T
        for (var i in fields) Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(0),
                width: 300,
                alignment: Alignment.centerLeft,
                child: Text(
                  i,
                  style: TextStyle(
                    fontSize: 14
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
                    fontSize: 14
                  ),
                ),
              ),
            ],
          )
        ),

        Padding(
          padding: EdgeInsets.all(10),
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
            'SIGN UP',
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
                "Already have an account? ",
                style: TextStyle(
                  fontSize: 12
                ),
              ),
              
              Text(
                'Log In.',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
        )
      ]
    );
  }
}