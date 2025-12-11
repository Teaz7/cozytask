import 'package:cozytask/dashboard.dart';
import 'package:cozytask/database/dbHelper.dart';
import 'package:cozytask/database/models/userModel.dart';
import 'package:cozytask/main.dart';
import 'package:cozytask/signUp.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ChooseAccPage());
}

class ChooseAccPage extends StatelessWidget {
  const ChooseAccPage({super.key});

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
          child: const ChooseAccount(),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ChooseAccount extends StatefulWidget {
  const ChooseAccount({super.key});

  @override
  State<ChooseAccount> createState() => _ChooseAccountState();
}

class _ChooseAccountState extends State<ChooseAccount> {
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  Future<void> loadUsers() async {
    final data = await DBHelper.instance.readAllUser();
    print("Loaded ${data.length} users");
    for (var user in data) {
      print("User: ${user.name}, ${user.email}");
    }
    setState(() {
      users = data;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(40),
        ),

        Container(
          padding: EdgeInsets.all(0),
          width: 300,
          alignment: Alignment.center,
          child: Text(
            'CHOOSE AN ACCOUNT',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0XFF68A3BC)
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.all(20),
        ),

        for (var i in users) Container(
          padding: EdgeInsets.symmetric(vertical: 7),
          width: 300,
          height: 65,
          child: ElevatedButton(
              onPressed: () {
                int? selectedUser;
                setState(() {
                  selectedUser = i.id;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardPage(userid: selectedUser,)),
                );
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(300, 60),
              backgroundColor: Color(0XFF004463),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)
              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      i.name,
                      textAlign: TextAlign.left,
                    ),

                    Text(
                      i.email,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color(0XFFD8E8F4),
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0XFFD8E8F4)
                      ),
                    )
                  ],
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Image.asset(
                      'assets/icon/Remove.png',
                      height: 30,
                    )
                  ],
                )
              ],
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.all(20),
        ),

        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUpPage()),
            );
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
                "Return to ",
                style: TextStyle(fontSize: 12),
              ),

              RichText(
                text: TextSpan(
                  text: 'Login?',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainPage()),
                      );
                    },
                ),
              ),
            ],
          ),
        ),
      ]
    );
  }
}