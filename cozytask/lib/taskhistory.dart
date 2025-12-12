import 'package:cozytask/components/backButton.dart';
import 'package:cozytask/components/taskwidget.dart';
import 'package:cozytask/database/dbHelper.dart';
import 'package:cozytask/database/models/taskModel.dart';
import 'package:flutter/material.dart';

class TaskHistoryPage extends StatelessWidget {
  final int? userid;
  const TaskHistoryPage({super.key, required this.userid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: TaskHistory(userid: userid,)));
  }
}

class TaskHistory extends StatefulWidget {
  final int? userid;
  const TaskHistory({super.key, required this.userid});

  @override
  State<TaskHistory> createState() => _TaskHistoryState();
}

class _TaskHistoryState extends State<TaskHistory> {
  List<Task> tasklist = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }
  
  Future<void> loadTasks() async {
    final data = await DBHelper.instance.readAllTask(widget.userid);
    setState(() {
      tasklist = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CustomBackButton(userid: widget.userid,),

        Container(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          width: 320,
          child: Text(
            'Task History',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: Color(0XFF004463),
            ),
          ),
        ),

        TaskWidget(
          tasklist: tasklist,
          userid: widget.userid,
          dashboard: false,
        )
      ]
    );
  }
}