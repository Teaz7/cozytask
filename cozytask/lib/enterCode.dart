import 'package:cozytask/components/backbutton_login.dart';
import 'package:cozytask/newPassword.dart'; 
import 'package:flutter/material.dart';

void main() {
  runApp(const enterCodePage());
}

class enterCodePage extends StatelessWidget {
  const enterCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Enter Code',
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ReturnLoginButton(),
                ),

                const SizedBox(height: 30),
                // Title
                Center(
                  child: Column(
                    children: const [
                      Text(
                        'ENTER VERIFICATION CODE',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color(0XFF004463),
                        ),
                      ),
                      SizedBox(height: 25),
                    ],
                  ),
                ),

                // Textfield
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0XFFD8E8F4),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Color(0XFF004463), 
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Color(0XFF004463), 
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Color(0XFF004463), 
                            width: 2,
                          ),
                        ),
                      ),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Note
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0XFF000000),
                        fontWeight: FontWeight.normal,
                      ),
                      children: [
                        TextSpan(text: "Didn't receive a code? "),
                        TextSpan(
                          text: "Resend.",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => newPasswordPage()),
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
                      'VERIFY',
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
