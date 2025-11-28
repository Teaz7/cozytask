import 'package:cozytask/components/backbutton.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const changePasswordPage());
}

class changePasswordPage extends StatelessWidget {
  const changePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> fields = ['Current Password', 'New Password','Confirm New Password'];

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
                  child: CustomBackButton(),
                ),

                Center(
                  child: Column(
                    children: const [
                      Text(
                        'CHANGE',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0XFF004463),
                        ),
                      ),
                      SizedBox(height: 5),
                    ],
                  ),
                ),

                Center(
                  child: Column(
                    children: const [
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

                // Text Fields Loop
                for (var i in fields)
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 5),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            i,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0XFF004463),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        // TextField box
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

                        if (i == 'New Password')
                          const Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Mainimum of 10 characters",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                const SizedBox(height: 30),

                // Buttons 
                Center(
                  child: Column(
                    children: [
                      // Save
                      ElevatedButton(
                        onPressed: () {},
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
                        onPressed: () {},
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
