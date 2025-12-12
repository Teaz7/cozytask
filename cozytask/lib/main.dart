import 'package:cozytask/chooseaccount.dart';
import 'package:cozytask/components/popupDialog.dart';
import 'package:cozytask/dashboard.dart';
import 'package:cozytask/database/dbHelper.dart';
import 'package:cozytask/forgotPassword.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cozytask/signUp.dart';

void main() {
  runApp(const MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
        fontFamily: 'GillSansMT',
      ),
      home: Scaffold(body: Center(child: Login())),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  int? userid;

  bool fieldsEmpty() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void clearField() {
    emailController.clear();
    passwordController.clear();
  }

  void resetDB() async {
    await DBHelper.instance.resetDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(padding: EdgeInsets.all(60)),

        Container(
          alignment: Alignment.center,
          child: Image.asset('assets/img/COZY_TASK_LOGO.png', height: 150),
        ),

        Container(
          alignment: Alignment.center,
          child: Image.asset(
            'assets/img/COZY_TASK_TEXT_BLUE_LOGO.png',
            height: 75,
          ),
        ),

        Padding(padding: EdgeInsets.all(35)),

        Container(
          padding: EdgeInsets.all(0),
          width: 300,
          alignment: Alignment.centerLeft,
          child: Text('Email Address:', style: TextStyle(fontSize: 14)),
        ),

        Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          width: 300,
          height: 50,
          child: TextField(
            controller: emailController,
            maxLines: 1,
            decoration: InputDecoration(
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(width: 0, style: BorderStyle.none),
              ),
              filled: true,
              fillColor: Color(0XFFD8E8F4),
            ),
            style: TextStyle(fontSize: 14),
          ),
        ),

        Padding(padding: EdgeInsets.all(5)),

        Container(
          padding: EdgeInsets.all(0),
          width: 300,
          alignment: Alignment.centerLeft,
          child: Text('Password:', style: TextStyle(fontSize: 14)),
        ),

        Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          width: 300,
          height: 50,
          child: TextField(
            controller: passwordController,
            obscureText: true,
            maxLines: 1,
            decoration: InputDecoration(
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(width: 0, style: BorderStyle.none),
              ),
              filled: true,
              fillColor: Color(0XFFD8E8F4),
            ),
            style: TextStyle(fontSize: 14),
          ),
        ),

        Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          width: 300,
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => forgotPasswordPage()),
              );
            },
            child: Text(
              'Forgot Password?',
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: Color(0XFF898989),
                decorationColor: Color(0XFF898989),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        Padding(padding: EdgeInsets.all(15)),

        ElevatedButton(
          onPressed: () async {
            if (fieldsEmpty()) {
              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return CustomDialog(
                    title: "Incomplete Username\nor Password",
                    message: "Click anywhere to continue...",
                    image: Image.asset(
                      'assets/img/COZY_TASK_LOGO.png',
                      width: 100,
                    ),
                  );
                },
              );
            } else {
              userid = await DBHelper.instance.returnUserID(
                emailController.text,
                passwordController.text,
              );

              if (userid != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DashboardPage(userid: userid),
                  ),
                );
              } else {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return CustomDialog(
                      title: "Invalid Username\nor Password",
                      message: "Click anywhere to continue...",
                      image: Image.asset(
                        'assets/img/COZY_TASK_LOGO.png',
                        width: 100,
                      ),
                    );
                  },
                );
              }
            }
            clearField();
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(220, 40),
            backgroundColor: Color(0XFF68A3BC),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: const Text(
            'LOGIN',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
          ),
        ),

        Padding(padding: EdgeInsets.all(5)),

        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChooseAccPage()),
            );
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(220, 40),
            backgroundColor: Color(0XFF68A3BC),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: const Text(
            'ACCOUNTS',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
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
                style: TextStyle(fontSize: 12),
              ),

              RichText(
                text: TextSpan(
                  text: 'Sign Up.',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
