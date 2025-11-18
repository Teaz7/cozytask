
import 'package:cozytask/components/backbutton.dart';
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Back Button
              CustomBackButton(),

              // Account Settings
              Container(
                padding: const EdgeInsets.only(top: 20),
                width: 300,
                child: const Text(
                  'Account Settings',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Color(0XFF004463),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(width: 40),
                  Image.asset(
                    'assets/icon/Profile.png',
                    alignment: Alignment.center,
                    width: 65,
                  ),
                  
                  const SizedBox(width: 20),

                  Padding(
                    padding: const EdgeInsets.only(right: 120),
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

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(width: 40),
                  Image.asset(
                    'assets/icon/ChangePassword.png',
                    alignment: Alignment.center,
                    width: 65,
                  ),

                  const SizedBox(width: 20),

                  Padding(
                    padding: const EdgeInsets.only(right: 70),
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
                width: 300,
                alignment: Alignment.centerLeft,
                child: const Text(
                  'About System',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Color(0XFF004463),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(width: 50),
                  
                  Image.asset(
                    'assets/icon/Help.png',
                    width: 55,
                    alignment: Alignment.center,
                  ),

                  const SizedBox(width: 25),

                  Padding(
                    padding: const EdgeInsets.only(right: 165),
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

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(width: 55),
                  Image.asset(
                    'assets/icon/About.png',
                    width: 50,
                  ),
                  const SizedBox(width: 25),

                  Padding(
                    padding: const EdgeInsets.only(right: 160),
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

              const SizedBox(height: 150),

              ElevatedButton(
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
            ],
          ),
        ),
      ),
    );
  }
}
