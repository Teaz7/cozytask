import 'package:cozytask/components/backbutton_login.dart';
import 'package:cozytask/enterCode.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const forgotPasswordPage());
}

class forgotPasswordPage extends StatelessWidget {
  const forgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forgot Password',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
        fontFamily: 'GillSansMT',
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //back button
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ReturnLoginButton(),
                ),

                //Icon
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/icon/ForgotPassword.png',
                        width: 150,
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),

                // Title
                Center(
                  child: Column(
                    children: const [
                      Text(
                        'FORGOT PASSWORD',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0XFF004463),
                        ),
                      ),
                      SizedBox(height: 10),

                      // description
                      Text(
                        'Provide your accounts email for which you',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0XFF7B7B7B),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'want to reset your password',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0XFF7B7B7B),
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 25),
                    ],
                  ),
                ),

                Center(
                  child: Column(
                    children: [
                      // Email label
                      const Text(
                        "Enter Email Address",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0XFF000000),
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),

                //Email Input
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0XFFD8E8F4),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                //Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => enterCodePage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(320, 40),
                      backgroundColor: const Color(0XFF004463),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'SEND CODE',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
