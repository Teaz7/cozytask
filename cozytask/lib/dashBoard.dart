import 'package:cozytask/dashboard2.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DashboardPage());
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
        fontFamily: 'GillSansMT'
      ),
      home: Scaffold(
        body: Center(
          child: const Dashboard(),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  
  /* ---- open the blue sheet ---- */
  void _openDrawer() => showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => _drawerSheet(),
  );

  /* ---- blue drawer content ---- */
  Widget _drawerSheet() => Container(
    height: 320,
    decoration: const BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    child: Column(
      children: [
        const SizedBox(height: 12),
        Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 20),
        /* row 1 */
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _tile(Icons.home, 'Home'),
            _tile(Icons.store, 'Store'),
            _tile(Icons.calendar_today, 'Calendar'),
          ],
        ),
        const SizedBox(height: 10),
        /* row 2 */
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _tile(Icons.settings, 'Settings'),
            _tile(Icons.person, 'Profile'),
            _tile(Icons.logout_outlined, 'Logout'),
          ],
        ),
      ],
    ),
  );

  /* ---- single icon + label ---- */
  Widget _tile(IconData icon, String label) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 70, color: Colors.white),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 14)),
      ],
    ),
  );
  
  @override
  Widget build(BuildContext context) {
    List<String> taskname = ['Research Worksheet 3', 'Networking Practical 1', 'App Dev Midterm Project'];
    List<String> duedate = ['10 DAYS REMAINING BEFORE DUE', 'End date: September 24, 2025', 'End date: October 3, 2025'];
    List<String> image = ['assets/icon/minipercentage/1.png', 'assets/icon/minipercentage/2.png', 'assets/icon/minipercentage/3.png'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(40),
        ),
        
        Container(
          alignment: Alignment.center,
          child: Image.asset(
            'assets/img/COZY_TASK_FULL_LOGO.png',
            height: 130,
          ),
        ),
        
        Padding(
          padding: EdgeInsets.all(10),
        ),

        Container(
          width: 320,
          height: 35,
          decoration: BoxDecoration(
            color: Color(0XFFD8E8F4),
            borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsetsGeometry.all(5),
              ),
              
              Image.asset(
                'assets/icon/Search.png',
                width: 20,
              ),
            ],
          ),
        ),

        Padding(
          padding: EdgeInsetsGeometry.all(10),
        ),

        Container(
          width: 340,
          height: 145,
          decoration: BoxDecoration(
            color: Color(0XFFD8E8F4),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Color(0XFF68A3BC),
              width: 3
            )
          ),
          child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Image.asset(
                          'assets/icon/Percentage.png',
                          width: 70,
                        )
                      ],
                    ),

                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(horizontal: 5),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              'App Dev Presentation',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                              ),
                            ),
                          ],
                        ),
                        
                        Row(
                          children: <Widget>[
                            Text(
                              '2 DAYS REMAINING BEFORE DUE',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0XFF004463),
                                fontSize: 12
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: <Widget>[
                            Text(
                              'Deadline: ',
                              textAlign: TextAlign.left,
                              style: TextStyle(),
                            ),

                            Text(
                              'September 24, 2025',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                Padding(
                  padding: EdgeInsetsGeometry.all(5),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          width: 150,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Color(0XFF68A3BC),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'View Task',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 18
                                ),
                              ),
                            ],
                          )
                        )
                      ],
                    ),

                    Padding(
                      padding: EdgeInsetsGeometry.all(5),
                    ),

                    Column(
                      children: <Widget>[
                        Container(
                          width: 150,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Color(0XFF004463),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Mark as Done',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 18
                                ),
                              ),
                            ],
                          )
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),

        Padding(
          padding: EdgeInsetsGeometry.all(10),
        ),

        for (int i = 0; i < taskname.length; i++) Column(
          children: <Widget>[
            Container(
              width: 340,
              height: 70,
              decoration: BoxDecoration(
                color: Color(0XFFD8E8F4),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Color(0XFF68A3BC),
                  width: 3
                )
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Image.asset(
                          image[i],
                          width: 40,
                        )
                      ],
                    ),

                    Padding(
                      padding: EdgeInsetsGeometry.all(5),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              taskname[i],
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              duedate[i],
                              textAlign: TextAlign.left,
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ),

            Padding(
              padding: EdgeInsetsGeometry.all(7),
            )
          ],
        ),

        Padding(
          padding: EdgeInsetsGeometry.all(5),
        ),

        ElevatedButton(
          onPressed: () {

          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(220, 40),
            backgroundColor: Color(0XFF004463),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)
            )
          ),
          child: const Text(
            'ADD TASK',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 21
              ),
            ),
        ),

        Padding(padding: EdgeInsetsGeometry.all(20)),

        Container(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: _openDrawer,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 45),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 200,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        )
        
      ],
    );
  }
}