import 'package:flutter/material.dart';
import 'package:cozytask/components/backButtonLogin.dart';
import 'package:cozytask/AdminSide/viewProfile';

class ViewUsersPage extends StatelessWidget {
  const ViewUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Users (Replace with the database)
    final List<Map<String, String>> users = [
      {"name": "Sean Patrick", "email": "sean@gmail.com"},
      {"name": "Pzalm Franz", "email": "pfranzee@gmail.com"},
      {"name": "Ty James", "email": "tyjames@gmail.com"},
      {"name": "James Galbiz", "email": "thejames@gmail.com"},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ReturnLoginButton(),
                const SizedBox(height: 15),

                const Center(
                  child: Text(
                    "USERS",
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Color(0XFF68A3BC),
                      fontFamily: 'GillSansMT',
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                Column(
                  children: users.map((user) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ViewProfilePage(
                              name: user["name"]!,
                              email: user["email"]!,
                              accountId: "21",
                              yearLevel: "3rd-year Student",
                              university: "West Visayas State University",
                              rank: "3",
                              points: "2100",
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                          color: const Color(0XFF004463),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 3),
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user["name"]!,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'GillSansMT',
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              user["email"]!,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                                fontFamily: 'GillSansMT',
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
