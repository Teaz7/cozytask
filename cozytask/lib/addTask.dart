import 'package:cozytask/components/backButton.dart';
import 'package:cozytask/components/popupDialog.dart';
import 'package:cozytask/dashboard.dart';
import 'package:cozytask/database/dbHelper.dart';
import 'package:cozytask/database/models/subtaskModel.dart';
import 'package:cozytask/database/models/taskModel.dart';
import 'package:flutter/material.dart';

class AddTaskPage extends StatelessWidget {
  final int? userid;
  const AddTaskPage({super.key, required this.userid});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Add Task',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
        fontFamily: 'GillSansMT',
      ),
      home: Scaffold(
        body: AddTask(userid: userid,),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AddTask extends StatefulWidget {
  final int? userid;
  const AddTask({super.key, required this.userid});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController nameController = TextEditingController();
  TextEditingController desriptionController = TextEditingController();
  TextEditingController subtaskController = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;

  int selectedPriorityIndex = 0;
  List<String> priority = ['1', '2', '3', '4', '5'];
  List<String> subtasks = [];

  String formatDate(DateTime? date) {
    if (date == null) return "Select Date";
    return "${date.day}/${date.month}/${date.year}";
  }

  Widget datePickerBox({
    required DateTime? date,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
        decoration: BoxDecoration(
          color: const Color(0XFFD8E8F4),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              formatDate(date),
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
            const Icon(Icons.arrow_drop_down, color: Colors.black, size: 25),
          ],
        ),
      ),
    );
  }

  bool fieldsEmpty() {
    if (
      nameController.text.isEmpty || desriptionController.text.isEmpty ||
      startDate == null || endDate == null
    ) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    void addTask() async {
      int taskid = await DBHelper.instance.createTask(Task(
        progress: 0,
        name: nameController.text,
        description: desriptionController.text,
        priority: selectedPriorityIndex,
        status: "Unfinished",
        datestart: formatDate(startDate),
        dateend: formatDate(endDate),
        userid: widget.userid,
        calid: await DBHelper.instance.returnCalendarID(widget.userid)
      ));

      for (var i in subtasks) {
        await DBHelper.instance.createSubtask(SubtTask(
          name: i,
          status: "unfinished",
          taskid: taskid
          ));
      }
    }

    void addSubtask() {
      if (subtaskController.text.isNotEmpty) {
        setState(() {
          subtasks.add(subtaskController.text);
          subtaskController.clear();
        });
      }
    }

    void removeSubtask(int index) {
      setState(() {
        subtasks.removeAt(index);
      });
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CustomBackButton(userid: widget.userid,),

          const SizedBox(height: 15),

          // Title
          Container(
            padding: const EdgeInsets.only(bottom: 30),
            width: 300,
            alignment: Alignment.center,
            child: const Text(
              'Add Task',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Color(0XFF004463),
              ),
            ),
          ),

          // Label
          Container(
            width: 320,
            alignment: Alignment.centerLeft,
            child: const Text('Task Name',
                style: TextStyle(fontSize: 14, color: Colors.black)),
          ),

          // Task Field
          Container(
            width: 320,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0XFFD8E8F4),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                controller: nameController,
                maxLines: 1,
                decoration: InputDecoration(
                  isDense: true,
                  isCollapsed: true,
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Description
          Container(
            width: 320,
            alignment: Alignment.centerLeft,
            child: const Text('Description',
                style: TextStyle(fontSize: 14, color: Colors.black)),
          ),

          // Description Field
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            width: 320,
            child: TextField(
              controller: desriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none),
                filled: true,
                fillColor: const Color(0XFFD8E8F4),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Date Labels
          Container(
            alignment: Alignment.center,
            width: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text('Start Date:', style: TextStyle(fontSize: 14)),
                SizedBox(width: 95),
                Text('End Date:', style: TextStyle(fontSize: 14)),
              ],
            ),
          ),

          const SizedBox(height: 5),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              datePickerBox(
                date: startDate,
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) setState(() => startDate = picked);
                },
              ),
              const SizedBox(width: 10),
              datePickerBox(
                date: endDate,
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) setState(() => endDate = picked);
                },
              ),
            ],
          ),

          const SizedBox(height: 15),

          // Prioritization
          Container(
            width: 300,
            alignment: Alignment.centerLeft,
            child: const Text('Prioritization',
                style: TextStyle(fontSize: 14)),
          ),

          // Checkboxes
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var index = 0; index < priority.length; index++)
                Row(
                  children: [
                    Checkbox(
                      value: selectedPriorityIndex == index,
                      onChanged: (val) {
                        setState(() {
                          selectedPriorityIndex = index;
                        });
                      },
                      fillColor:
                          WidgetStateProperty.resolveWith<Color>((states) {
                        if (states.contains(WidgetState.selected)) {
                          return const Color(0XFF004463);
                        }
                        return Colors.white;
                      }),
                    ),
                    Text(priority[index]),
                    const SizedBox(width: 5),
                  ],
                ),
            ],
          ),

          const SizedBox(height: 10),

          // Subtask 
          Container(
            width: 320,
            height: 40,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: subtaskController,
                    decoration: InputDecoration(
                      hintText: 'Add Subtask...',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: const Color(0XFFD8E8F4),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: addSubtask,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(25, 30),
                    backgroundColor: const Color(0XFF004463),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  child: const Text(
                    '+',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 21),
                  ),
                ),
              ],
            ),
          ),

          Container(
            width: 320,
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: subtasks.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 40,
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0XFFD8E8F4),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          subtasks[index],
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, size: 10),
                        onPressed: () => removeSubtask(index),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 50),

          // Custom Dialog
          ElevatedButton(
            onPressed: () {
              if (!fieldsEmpty()) {
                addTask();
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return CustomDialog(
                      title: "TASK ADDED\nSUCCESSFULLY!",
                      message: "Click anywhere to continue...",
                      image: Image.asset(
                        'assets/img/COZY_TASK_LOGO.png',
                        width: 100,
                      ),
                    );
                  },
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardPage(userid: widget.userid,)),
                );
              } else {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return CustomDialog(
                      title: "Please do not\nleave any field blank",
                      message: "Click anywhere to continue...",
                      image: Image.asset(
                        'assets/img/COZY_TASK_LOGO.png',
                        width: 100,
                      ),
                    );
                  },
                );
              }
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(260, 40),
              backgroundColor: const Color(0XFF004463),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text(
              'ADD TASK',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}