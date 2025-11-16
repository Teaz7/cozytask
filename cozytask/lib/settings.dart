import 'package:flutter/material.dart';

void main() {
  runApp(const SettingsPage());
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
        fontFamily: 'GillSansMT',
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),

              // Back Button
              Padding(
                padding: const EdgeInsets.all(20),
                child: Image.asset(
                  'assets/icon/BackButton.png',
                  height: 30,
                ),
              ),

              // Account Settings
              Container(
                padding: const EdgeInsets.only(top: 20),
                width: 300,
                alignment: Alignment.center,
                child: const Text(
                  'Account Settings',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0XFF004463),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(width: 55),
                  Image.asset(
                    'assets/icon/Profile.png',
                    width: 65,
                    height: 65,
                  ),
                  const SizedBox(width: 30),

                  Padding(
                    padding: const EdgeInsets.only(right: 150),
                    child: const Text(
                      'Edit Profile',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),

                  IconButton(
                    icon: const Icon(Icons.arrow_right),
                    onPressed: () {
                      print('Edit Profile');
                    },
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(width: 53),
                  Image.asset(
                    'assets/icon/ChangePassword.png',
                    width: 65,
                    height: 65,
                  ),
                  const SizedBox(width: 30),

                  Padding(
                    padding: const EdgeInsets.only(right: 100),
                    child: const Text(
                      'Change Password',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),

                  IconButton(
                    icon: const Icon(Icons.arrow_right),
                    onPressed: () {
                      print('Change Password');
                    },
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.only(top: 20),
                width: 280,
                alignment: Alignment.center,
                child: const Text(
                  'About System',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0XFF004463),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(width: 65),
                  Image.asset(
                    'assets/icon/Help.png',
                    width: 55,
                    height: 55,
                  ),
                  const SizedBox(width: 30),

                  Padding(
                    padding: const EdgeInsets.only(right: 195),
                    child: const Text(
                      'Help',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),

                  IconButton(
                    icon: const Icon(Icons.arrow_right),
                    onPressed: () {
                      print('Help');
                    },
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(width: 65),
                  Image.asset(
                    'assets/icon/About.png',
                    width: 52,
                    height: 52,
                  ),
                  const SizedBox(width: 30),

                  Padding(
                    padding: const EdgeInsets.only(right: 185),
                    child: const Text(
                      'About',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),

                  IconButton(
                    icon: const Icon(Icons.arrow_right),
                    onPressed: () {
                      print('About');
                    },
                  ),
                ],
              ),

              const SizedBox(height: 120),

              Padding(
                padding: const EdgeInsets.only(left: 150),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(250, 40),
                    backgroundColor: const Color(0XFF004463),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text(
                    'LOG OUT',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
