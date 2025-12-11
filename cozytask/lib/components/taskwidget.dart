import 'package:cozytask/database/models/taskModel.dart';
import 'package:cozytask/viewTask.dart';
import 'package:flutter/material.dart';

class TaskWidget extends StatefulWidget {
  final List<Task> tasklist;
  final String icon;
  final int? userid;

  const TaskWidget({
    Key? key, 
    required this.tasklist,
    required this.icon,
    required this.userid
  }) : super(key: key);

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  List<bool> isOpenedList = [];

  void toggleTask(int i) {
    setState(() {
      isOpenedList[i] = !isOpenedList[i];
    });
  }

  @override
  void initState() {
    super.initState();
    isOpenedList = List.generate(widget.tasklist.length, (_) => false);
  }

  @override
  void didUpdateWidget(TaskWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update isOpenedList when tasklist changes
    if (oldWidget.tasklist.length != widget.tasklist.length) {
      isOpenedList = List.generate(widget.tasklist.length, (_) => false);
    }
  }

  @override
  Widget build(BuildContext context) {

    Widget closedTab(String image, String task, String remaining) => Column(
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
                      image,
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
                          task,
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
                          remaining.toString(),
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
          padding: EdgeInsetsGeometry.all(5),
        )
      ],
    );

    Widget openedTab(String task, String remaining, String duedate) => Column(
      children: <Widget>[
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
                              task,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: <Widget>[
                            Text(
                              remaining.toString(),
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
                              duedate,
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
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ViewTaskPage(userid: widget.userid,)),
                            );
                          },
                          child: Container(
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
                          ),
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
          padding: EdgeInsetsGeometry.all(5),
        )
      ]
    );

    String remainingDays(Task task) {
      DateTime start;
      DateTime end;
      
      // Check if it's in MM/DD/YYYY format
      if (task.datestart.contains('/')) {
        List<String> startParts = task.datestart.split('/');
        start = DateTime(
          int.parse(startParts[1]), // year
          int.parse(startParts[2]), // month
          int.parse(startParts[0])  // day
        );
      } else {
        start = DateTime.parse(task.datestart);
      }
      
      if (task.dateend.contains('/')) {
        List<String> endParts = task.dateend.split('/');
        end = DateTime(
          int.parse(endParts[1]), // year
          int.parse(endParts[2]), // month
          int.parse(endParts[0])  // day
        );
      } else {
        end = DateTime.parse(task.dateend);
      }
      
      Duration difference = end.difference(start);
      return "${difference.inDays} days remaining";
    }

    return Column(
      children: <Widget>[
        for (int i = 0; i < widget.tasklist.length; i++) GestureDetector(
          onTap: () => toggleTask(i),
          child: isOpenedList[i]
              ? openedTab(widget.tasklist[i].name, remainingDays(widget.tasklist[i]), widget.tasklist[i].dateend)
              : closedTab(widget.icon, widget.tasklist[i].name, remainingDays(widget.tasklist[i]))
        )
      ],
    );
  }
}