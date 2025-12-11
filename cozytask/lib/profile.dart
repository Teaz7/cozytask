import 'package:cozytask/components/backButton.dart';
import 'package:cozytask/database/dbHelper.dart';
import 'package:cozytask/main.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final int? userid;
  const ProfilePage({super.key, required this.userid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Profile(userid: userid,));
  }
}

class Profile extends StatefulWidget {
  final int? userid;
  const Profile({super.key, required this.userid});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final List<String> labels = [
    'Account ID',
    'Year Level',
    'University',
    'Rank',
    'Current Points'
  ];
  final List<String> personalInfo = [
    '21',
    '3rd-year Student',
    'West Visayas State University',
    '#3',
    '2100 points'
  ];

  Future<void> deleteUser(int? id) async {
    if (id != null) {
      await DBHelper.instance.deleteUser(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          CustomBackButton(userid: widget.userid,),

          const SizedBox(height: 10),

          
          Container(
            width: 320,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: const Color(0XFF68A4BC),
                width: 3,
              ),
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
                  textAlign: TextAlign.center,
                ),
                
                Image.asset(
                  'assets/icon/UserProfile.png',
                  width: 120,
                ),
                const Text(
                  'Pzalm Franzenne',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0XFF004463),
                  ),
                ),
                const Text(
                  'pzalmfranzenne@gmail.com',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0XFF626262),
                  ),
                ),
                const SizedBox(height: 15),

                Column(
                  children: List.generate(labels.length, (i) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 5),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              '${labels[i]}:',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13.5,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Container(
                            height: 20,
                            width: 1,
                            color: const Color(0xFF68A3BC),
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                          ),
                          Expanded(
                            flex: 6,
                            child: Text(
                              personalInfo[i],
                              style: const TextStyle(
                                fontSize: 13.5,
                                color: Colors.black,
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

          const SizedBox(height: 10),

          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(320, 40),
              backgroundColor: const Color(0XFF004463),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: const Text(
              'View Leaderboard',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18,
              ),
            ),
          ),

          const SizedBox(height: 5),

          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(320, 40),
              backgroundColor: const Color(0XFF68A3BC),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: const Text(
              'View History',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18,
              ),
            ),
          ),

          const SizedBox(height: 5),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0XFF68A3BC),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text(
                    'Edit Account',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              SizedBox(
                width: 165,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) {
                        return CustomDialog(
                          title: "REMOVING\nACCOUNT",
                          message:
                              "Are you sure you want to\nremove this account?",
                          onConfirm: () async {
                            Navigator.of(context).pop();

                            await deleteUser(widget.userid);
                            print("Account removed! ${widget.userid}");

                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => MainPage()),
                              (route) => false,
                            );
                          },
                          onCancel: () {
                            Navigator.of(context).pop();
                          },
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0XFF68A3BC),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  child: const Text(
                    'Remove Account',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class CustomDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onCancel;
  final Future<void> Function() onConfirm;

  const CustomDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onCancel,
    required this.onConfirm
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {}, 
      child: Material(
        color: Colors.black.withOpacity(0.3),
        child: Center(
          child: Container(
            width: 330,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0XFF004463),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () async {
                    await onConfirm();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(260, 40),
                    backgroundColor: const Color(0XFF004463),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  child: const Text(
                    'CONFIRM',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: onCancel,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(260, 40),
                    backgroundColor: const Color(0XFF7B7B7B),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  child: const Text(
                    'CANCEL',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
