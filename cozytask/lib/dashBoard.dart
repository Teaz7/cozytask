import 'package:flutter/material.dart';

void main() {
  runApp(const DashBoardApp());
}

class DashBoardApp extends StatelessWidget {
  const DashBoardApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
        fontFamily: 'GillSansMT',
      ),
      home: Scaffold(body: Center(child: const Login())),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _dashBoardState();
}

class _dashBoardState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 200.0,
          height: 6.0,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(3.0),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: Icon(Icons.home, size: 75, color: Colors.blueAccent),
                ),
                Text('Home', style: TextStyle(fontSize: 16)),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: Icon(Icons.store, size: 75, color: Colors.blueAccent),
                ),
                Text('Store', style: TextStyle(fontSize: 16)),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: Icon(
                    Icons.calendar_today,
                    size: 75,
                    color: Colors.blueAccent,
                  ),
                ),
                Text('Calendar', style: TextStyle(fontSize: 16)), // added label
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                  child: Icon(
                    Icons.settings,
                    size: 75,
                    color: Colors.blueAccent,
                  ),
                ),
                Text('Settings', style: TextStyle(fontSize: 16)),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                  child: Icon(Icons.person, size: 75, color: Colors.blueAccent),
                ),
                Text('Profile', style: TextStyle(fontSize: 16)),
              ],
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                  child: Icon(
                    Icons.logout_outlined,
                    size: 75,
                    color: Colors.blueAccent,
                  ),
                ),
                Text('Logout', style: TextStyle(fontSize: 16)),
              ],
            ),
          ],
        ),
      ], // 2. closing bracket added
    );
  }
}
