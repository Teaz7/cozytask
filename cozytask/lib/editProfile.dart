import 'package:cozytask/components/backButton.dart';
import 'package:flutter/material.dart';

class editProfilePage extends StatelessWidget {
  final int? userid;
  const editProfilePage({super.key, required this.userid});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edit Profile',
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
                // Back Button
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: CustomBackButton(userid: userid,),
                ),

                // EDIT PROFILE
                Center(
                  child: Column(
                    children: [
                      const Text(
                        'EDIT PROFILE',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0XFF004463),
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Profile Image
                      Image.asset(
                        'assets/icon/UserProfile.png',
                        width: 150,
                      ),
                      const SizedBox(height: 35),
                    ],
                  ),
                ),

                // Username
                const Text(
                  "Username",
                  style: TextStyle(
                    color: Color(0XFF004463),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                TextField(
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0XFF004463)),
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                // Year Level
                const Text(
                  "Year Level",
                  style: TextStyle(
                    color: Color(0XFF004463),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                TextField(
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0XFF004463)),
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                // University
                const Text(
                  "University",
                  style: TextStyle(
                    color: Color(0XFF004463),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                TextField(
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0XFF004463)),
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                // Email
                const Text(
                  "Email Address",
                  style: TextStyle(
                    color: Color(0XFF004463),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                TextField(
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0XFF004463)),
                    ),
                  ),
                ),
                const SizedBox(height: 40),

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

                      const Padding(padding: EdgeInsets.all(5)),

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
