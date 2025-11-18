import 'package:cozytask/components/backbutton.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ProfilePage());
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
        fontFamily: 'GillSansMT',
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Profile()
      ),
    );
  }
}

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<String> labels = ['Account ID', 'Year Level', 'University', 'Rank', 'Current Points'];
  List<String> personalInfo = ['21','3rd-year Student', 'West Visayas State University', '#3', '2100 points'];
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          // Back button
          CustomBackButton(),

          SizedBox(height: 10,),

          // Profile container
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
                // Profile Icon
                Image.asset(
                  'assets/icon/UserProfile.png',
                  width: 120,
                ),
                // Name
                const Text(
                  'Pzalm Franzenne',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0XFF004463),
                  ),
                ),
                // Email
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
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              labels[i] + ":",
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
                            margin:
                                const EdgeInsets.symmetric(horizontal: 10),
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
            //Leaderboard
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
            //History
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
                    'Edit Account', //Edit
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              SizedBox(
                width: 165,
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
                    'Remove Account', //Remove
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
