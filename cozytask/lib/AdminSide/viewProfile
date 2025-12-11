import 'package:flutter/material.dart';
import 'package:cozytask/components/backButton.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ViewProfile(
          name: name,
          email: email,
          accountId: accountId,
          yearLevel: yearLevel,
          university: university,
          rank: rank,
          points: points,
        ),
      ),
    );
  }
}

class ViewProfile extends StatefulWidget {
  final String name;
  final String email;
  final String accountId;
  final String yearLevel;
  final String university;
  final String rank;
  final String points;

  const ViewProfile({
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
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  @override
  Widget build(BuildContext context) {
    final List<String> labels = [
      'Account ID',
      'Year Level',
      'University',
      'Rank',
      'Current Points',
    ];

    final List<String> info = [
      widget.accountId,
      widget.yearLevel,
      widget.university,
      widget.rank,
      widget.points,
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Align(
            alignment: Alignment.centerLeft,
            child: CustomBackButton(userid: null),
          ),

          const SizedBox(height: 40),

          // Center the profile card
          Center(
            child: Container(
              width: 320,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Color(0XFF68A4BC), width: 3),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center, 
                children: [
                  const Text(
                    'USER PROFILE',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0XFF68A3BC),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Image.asset('assets/icon/UserProfile.png', width: 120),

                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0XFF004463),
                    ),
                  ),

                  Text(
                    widget.email,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0XFF626262),
                    ),
                  ),

                  const SizedBox(height: 15),

                  Column(
                    children: List.generate(labels.length, (i) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 5,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 4,
                              child: Text(
                                '${labels[i]}:',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.5,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),

                            Container(
                              height: 20,
                              width: 1,
                              color: Color(0xFF68A3BC),
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                            ),

                            Expanded(
                              flex: 6,
                              child: Text(
                                info[i],
                                style: const TextStyle(
                                  fontSize: 13.5,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
