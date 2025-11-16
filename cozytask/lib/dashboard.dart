import 'package:cozytask/bottomnavbar.dart';
import 'package:cozytask/taskwidget.dart';
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
          child: Stack(
            children: [
              Positioned.fill(
                child: Dashboard()
              ),
              BottomNavBar()
            ],
          ),
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

  List<String> taskname = ['Research Worksheet 3', 'Networking Practical 1', 'App Dev Midterm Project'];
  List<String> remaining = ['10 DAYS REMAINING BEFORE DUE', '2 DAYS REMAINING BEFORE DUE', '11 DAYS REMAINING BEFORE DUE'];
  List<String> duedate = ['October 2, 2025', 'September 24, 2025', 'October 3, 2025'];
  List<String> icon = ['assets/icon/minipercentage/1.png', 'assets/icon/minipercentage/2.png', 'assets/icon/minipercentage/3.png'];
  
  @override
  Widget build(BuildContext context) {

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

              Padding(
                padding: EdgeInsetsGeometry.all(3),
              ),

              SizedBox(
                width: 280,
                child: TextField(
                  maxLines: 1,
                  decoration: InputDecoration(
                    isDense: true,
                    isCollapsed: true,
                    hintText: 'Search Here...',
                    hintStyle: TextStyle(
                      color: Color(0XFF68A3BC)
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 0, style: BorderStyle.none),
                    )
                  ),
                ),
              )
            ],
          ),
        ),

        Padding(
          padding: EdgeInsetsGeometry.all(10),
        ),

        TaskWidget(
          taskname: taskname, remaining: remaining, duedate: duedate, icon: icon
        ),

        Padding(
          padding: EdgeInsetsGeometry.all(20),
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
      ],
    );
  }
}