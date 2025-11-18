import 'package:cozytask/dashboard.dart';
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
  @override
  Widget build(BuildContext context) {
    //Following the figma design muna
    List<String> username = ['Sean Patrick', 'Pzam Franz', 'Ty James', 'James Galbiz',
    'Peter James', 'Jay Ivan', 'Vonn Vonita', 'RJ Jeshrell'];
    List<String> email = ['sean@gmail.com', 'pfranzee@gmail.com', 'tyjames@gmail.com',
    'thejames@gmail.com', 'peterj@gmail.com', 'tuante@gmail.com', 'vonvon@gmail.com', 'rjjeshrell@gmail.com'];
    
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(45),
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

        for (int i = 0; i < username.length; i++) Container(
          padding: EdgeInsets.symmetric(vertical: 7),
          width: 300,
          height: 65,
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardPage()),
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
                      username[i],
                      textAlign: TextAlign.left,
                    ),

                    Text(
                      email[i],
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
        )
      ]
    );
  }
}