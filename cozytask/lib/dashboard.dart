import 'package:cozytask/addTask.dart';
import 'package:cozytask/components/bottomnavbar.dart';
import 'package:cozytask/components/taskWidget.dart';
import 'package:cozytask/database/dbHelper.dart';
import 'package:cozytask/database/models/taskModel.dart';
import 'package:cozytask/searchResult.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  final int? userid;
  const DashboardPage({super.key, required this.userid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Positioned.fill(
              child: Dashboard(userid: userid,)
            ),
            BottomNavBar(userid: userid,)
          ],
        ),
      ),
    );
  }
}

class Dashboard extends StatefulWidget {
  final int? userid;
  const Dashboard({super.key, required this.userid});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Task> tasklist = [];
  TextEditingController searchController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    loadTasks();
  }
  
  Future<void> loadTasks() async {
    print('Loading tasks for userid: ${widget.userid}');
    final data = await DBHelper.instance.readAllTask(widget.userid);
    print('Tasks loaded: ${data.length}');
    for (var task in data) {
      print('Task: ${task.name}, Start: ${task.datestart}, End: ${task.dateend}');
    }
    setState(() {
      tasklist = data;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    print('Dashboard userid: ${widget.userid}');
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

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 240,
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
                    width: 200,
                    child: TextField(
                      controller: searchController,
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
              padding: EdgeInsetsGeometry.all(3),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchResultPage(userid: widget.userid, search: searchController.text,)),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(90, 35),
                backgroundColor: Color(0XFF004463),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
              child: const Text(
                'Search',
                style: TextStyle(
                  fontSize: 16
                ),
              ),
            )
          ],
        ),

        Padding(
          padding: EdgeInsetsGeometry.all(3),
        ),

        TaskWidget(
          tasklist: tasklist,
          userid: widget.userid,
          dashboard: true,
          loadTask: loadTasks,
        ),

        Padding(
          padding: EdgeInsetsGeometry.all(15),
        ),

        ElevatedButton(
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddTaskPage(userid: widget.userid, loadTask: loadTasks,)),
            );
            await loadTasks();
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