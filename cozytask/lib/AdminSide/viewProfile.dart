import 'package:flutter/material.dart';

class ViewProfilePage extends StatelessWidget {
  final String name;
  final String email;
  final String accountId;
  final String yearLevel;
  final String university;
  final String rank;
  final String points;

  const ViewProfilePage({
    super.key,
    required this.name,
    required this.email,
    required this.accountId,
    required this.yearLevel,
    required this.university,
    required this.rank,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0XFF68A3BC),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "User Profile",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'GillSansMT',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: const Color(0XFF68A3BC),
                      child: Text(
                        name
                            .split(' ')
                            .map((e) => e[0])
                            .take(2)
                            .join()
                            .toUpperCase(),
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0XFF004463),
                        fontFamily: 'GillSansMT',
                      ),
                    ),
                    Text(
                      email,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontFamily: 'GillSansMT',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0XFF004463),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow("Account ID", accountId),
                    const SizedBox(height: 15),
                    _buildDetailRow("University", university),
                    const SizedBox(height: 15),
                    _buildDetailRow("Year Level", yearLevel),
                    const SizedBox(height: 15),
                    _buildDetailRow("Rank", "Rank #$rank"),
                    const SizedBox(height: 15),
                    _buildDetailRow("Points", "$points pts"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white70,
            fontFamily: 'GillSansMT',
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'GillSansMT',
          ),
        ),
      ],
    );
  }
}
