import 'package:cozytask/components/backButton.dart';
import 'package:cozytask/components/circlepercent.dart';
import 'package:cozytask/dashboard.dart';
import 'package:cozytask/database/dbHelper.dart';
import 'package:cozytask/database/models/subtaskModel.dart';
import 'package:flutter/material.dart';

/* -------------------------------------------------- */
/*  App shell                                         */
/* -------------------------------------------------- */
class ViewTaskPage extends StatelessWidget {
  final int? userid, taskid;
  const ViewTaskPage({super.key, this.userid, required this.taskid});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
        fontFamily: 'GillSansMT',
      ),
      home: Scaffold(body: Center(child: ViewTask(userid: userid, taskid: taskid,))),
      debugShowCheckedModeBanner: false,
    );
  }
}

/* -------------------------------------------------- */
/*  View-Task page                                    */
/* -------------------------------------------------- */
class ViewTask extends StatefulWidget {
  final int? userid, taskid;
  const ViewTask({super.key, this.userid, required this.taskid});

  @override
  State<ViewTask> createState() => _ViewTaskState();
}

class _ViewTaskState extends State<ViewTask> {

  List<SubtTask> subtasklist = [];
  TextEditingController subtaskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadTasks();
  }
  
  Future<void> loadTasks() async {
    final data = await DBHelper.instance.readAllSubtask(widget.taskid);
    setState(() {
      subtasklist = data;
    });
  }

  void addSubtask() async {
    await DBHelper.instance.createSubtask(SubtTask(
      name: subtaskController.text,
      status: "unfinished",
      taskid: widget.taskid
    ));
    loadTasks();
    subtaskController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DBHelper.instance.returnTask(widget.taskid),
      builder: (context, snapshot) {
        final task = snapshot.data;
        return Column(
          children: <Widget>[
            CustomBackButton(userid: widget.userid,),

            const SizedBox(height: 10),
            Center(
              child: CirclePercent(
                percent: task!.progress * 0.01,
                radius: 85,
                ringColor: const Color(0xFF004562),
                ringWidth: 25,
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 10),
              child: Text(
                task.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF004562),
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.check_circle, color: Color(0xFF004562), size: 30),
                Text(
                  'Priority: ',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                Text(
                  (task.priority + 1).toString(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  'Status: ',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                Text(
                  task.status,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 2),
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 360),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD8E8F5),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    task.description,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 2),

            Row(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: Text(
                      'Start Date:',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 150),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0, top: 10),
                    child: Text(
                      'End Date:',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Row(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFD8E8F5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              task.datestart,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Color(0xFF004562),
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 95),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0, top: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFD8E8F5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              task.dateend,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Color(0xFF004562),
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Text(
                  'Subtasks',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
              child: ListView(
                padding: const EdgeInsets.only(top: 8, left: 20),
                children: [
                  for (var i in subtasklist) _subTaskRow(
                    i.name, i.status, (newValue) {
                      setState(() {
                        i.status = newValue;
                      });
                    }
                  )
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: SizedBox(
                    width: 270,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFD8E8F5),
                        borderRadius: BorderRadius.circular(8),
                      ),
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
                  ),
                ),

                const SizedBox(width: 10,),

                ElevatedButton(
                  onPressed: addSubtask,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(25, 50),
                    backgroundColor: Color(0XFF004463),
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
            const SizedBox(height: 35),
            Column(
              children: [
                SizedBox(
                  width: 320,
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              'MARK TASK AS COMPLETE',
                              textAlign: TextAlign.center,
                            ),
                            titleTextStyle: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 25,
                              color: Color(0xFF004562),
                            ),
                            content: const Text(
                              'Are you sure you want to mark this task as complete?',
                              textAlign: TextAlign.center,
                            ),
                            actionsAlignment: MainAxisAlignment.center,
                            actions: [
                              SizedBox(
                                width: 220,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    TextButton(
                                      onPressed: () async{
                                        await DBHelper.instance.taskMarkAsDone(widget.taskid!);
                                        Navigator.pop(context);
                                        // Show success dialog
                                        showDialog(
                                          context: context,
                                          barrierDismissible: true,
                                          builder: (BuildContext context) {
                                            return GestureDetector(
                                              onTap: () =>
                                                  Navigator.of(context).pop(),
                                              child: AlertDialog(
                                                backgroundColor: Colors.white,
                                                elevation: 4,
                                                content: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Image.asset(
                                                      'assets/img/COZY_TASK_LOGO.png',
                                                      width: 150,
                                                      height: 100,
                                                    ),
                                                    const SizedBox(height: 10),
                                                    const Text(
                                                      'TASK AS COMPLETED',
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w800,
                                                        fontSize: 25,
                                                        color: Color(0xFF004562),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 8),
                                                    const Text(
                                                      'You have received an additional 500 points in this account.',
                                                      textAlign: TextAlign.center,
                                                    ),
                                                    const SizedBox(height: 16),
                                                    const Text(
                                                      'Click anywhere to exit',
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: const Color(0xFF004562),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 60,
                                          vertical: 12,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                      ),
                                      child: const Text(
                                        'CONFIRM',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      style: TextButton.styleFrom(
                                        backgroundColor: Color(0XFF7b7b7b),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 60,
                                          vertical: 12,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                      ),
                                      child: const Text(
                                        'CANCEL',
                                        style: TextStyle(
                                          color: Color.fromARGB(221, 255, 255, 255),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF004562),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(width: 8),
                          Text(
                            'MARK AS DONE',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // DELETE TASK BUTTON
                SizedBox(
                  width: 320,
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              'DELETE TASK',
                              textAlign: TextAlign.center,
                            ),
                            titleTextStyle: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 25,
                              color: Color(0xFF004562),
                            ),
                            content: const Text(
                              'Are you sure you want to delete this task?',
                              textAlign: TextAlign.center,
                            ),
                            actionsAlignment: MainAxisAlignment.center,
                            actions: [
                              SizedBox(
                                width: 220,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    TextButton(
                                      onPressed: () async {
                                        for (var i in subtasklist) {
                                          await DBHelper.instance.deleteSubtask(i.id!);
                                        }
                                        await DBHelper.instance.deleteTask(widget.taskid!);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => DashboardPage(userid: widget.userid,)),
                                        );
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                          255,
                                          0,
                                          68,
                                          99,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 60,
                                          vertical: 12,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                      ),
                                      child: const Text(
                                        'CONFIRM',
                                        style: TextStyle(
                                          color: Color.fromARGB(221, 255, 255, 255),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      style: TextButton.styleFrom(
                                        backgroundColor: const Color(0xFF7b7b7b),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 60,
                                          vertical: 12,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                      ),
                                      child: const Text(
                                        'CANCEL',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0XFF7b7b7b),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(width: 8),
                          Text(
                            'DELETE TASK',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _subTaskRow(String text, String value, ValueChanged<String> onChanged) => Padding(
    padding: const EdgeInsets.only(left: 25),
    child: Row(
      children: [
        Checkbox(
          value: value == "finished",
          onChanged: (checked) => onChanged(checked == true ? "finished" : "unfinished"),
          activeColor: const Color(0xFF004562),
        ),
        GestureDetector(
          onTap: () => onChanged(value == "finished" ? "unfinished" : "finished"),
          child: Text(
            text,
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
        ),
      ],
    ),
  );
}
