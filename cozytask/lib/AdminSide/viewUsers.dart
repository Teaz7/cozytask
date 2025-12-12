import 'package:flutter/material.dart';
import 'package:cozytask/components/backButtonLogin.dart';
import 'package:cozytask/AdminSide/viewProfile.dart';
import 'package:cozytask/database/dbHelper.dart';
import 'package:cozytask/database/models/userModel.dart';

class ViewUsersPage extends StatefulWidget {
  const ViewUsersPage({super.key});

  @override
  State<ViewUsersPage> createState() => _ViewUsersPageState();
}

class _ViewUsersPageState extends State<ViewUsersPage> {
  late Future<List<User>> _usersFuture;

  @override
  void initState() {
    super.initState();
    _usersFuture = DBHelper.instance.readAllUser();
  }

  // Helper function to convert year number to ordinal string (1 -> "1st-year")
  String _formatYearLevel(int year) {
    if (year == 1) return "1st-year Student";
    if (year == 2) return "2nd-year Student";
    if (year == 3) return "3rd-year Student";
    return "$year-th-year Student";
  }

  @override
  Widget build(BuildContext context) {
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
                
                FutureBuilder<List<User>>(
                  future: _usersFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(color: Color(0XFF68A3BC)),
                      );
                    }
                    
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "Error loading users: ${snapshot.error}",
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }
                    
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text(
                          "No users found",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontFamily: 'GillSansMT',
                          ),
                        ),
                      );
                    }
                    
                    final users = snapshot.data!;
                    return Column(
                      children: users.map((user) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ViewProfilePage(
                                  name: user.name,
                                  email: user.email,
                                  accountId: user.id?.toString() ?? "N/A",
                                  yearLevel: _formatYearLevel(user.year), // Use 'year' field
                                  university: user.university,
                                  rank: ((user.points ~/ 1000) + 1).toString(),
                                  points: user.points.toString(),
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
                                  user.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: 'GillSansMT',
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  user.email,
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
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
