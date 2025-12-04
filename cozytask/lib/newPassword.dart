import 'package:cozytask/components/backbutton_login.dart';
import 'package:cozytask/forgotPassword.dart';
import 'package:cozytask/main.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const newPasswordPage());
}

class newPasswordPage extends StatelessWidget {
  const newPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> fields = ['New Password', 'Confirm New Password'];

    return MaterialApp(
      title: 'Change Password',
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

                const SizedBox(height: 40),

                // Title
                Center(
                  child: Column(
                    children: const [
                      Text(
                        'ENTER NEW',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0XFF004463),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'PASSWORD',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0XFF004463),
                        ),
                      ),
                      SizedBox(height: 25),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // Password
                for (var i in fields)
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          i,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0XFF004463),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                      
                        SizedBox(
                          height: 50,
                          child: TextField(
                            obscureText: true,
                            maxLength: 10,
                            decoration: InputDecoration(
                              counterText: "",
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
                      
                        // Hint for password
                        if (i == 'New Password')
                          const Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                              "Minimum of 10 characters",
                              style: TextStyle(
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                const SizedBox(height: 75),

                // Buttons
                Center(
                  child: Column(
                    children: [
                      
                      // Save
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MainPage()),
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
                          'SAVE CHANGES',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 21,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Cancel 
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => forgotPasswordPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(320, 40),
                          backgroundColor: const Color(0XFF7B7B7B),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'CANCEL',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 21,
                          ),
                        ),
                      ),
                    ],
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
