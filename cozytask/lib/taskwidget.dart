import 'package:flutter/material.dart';

class TaskWidget extends StatefulWidget {
  final List<String> taskname;
  final List<String> remaining;
  final List<String> duedate;
  final List<String> icon;

  const TaskWidget({
    Key? key, 
    required this.taskname,
    required this.remaining,
    required this.duedate,
    required this.icon
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
    isOpenedList = List.generate(widget.taskname.length, (_) => false);
  }

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
                          remaining,
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
                              remaining,
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
          padding: EdgeInsetsGeometry.all(5),
        )
      ]
    );

    return Column(
      children: <Widget>[
        for (int i = 0; i < widget.taskname.length; i++) GestureDetector(
          onTap: () => toggleTask(i),
          child: isOpenedList[i]
              ? openedTab(widget.taskname[i], widget.remaining[i], widget.duedate[i])
              : closedTab(widget.icon[i], widget.taskname[i], widget.remaining[i])
        )
      ],
    );
  }
}