import 'package:cozytask/components/backButton.dart';
import 'package:cozytask/dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AddTaskPage());
}

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key});

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
        body: AddTask(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  DateTime? startDate;
  DateTime? endDate;

  int? selectedPriorityIndex;
  List<String> priority = ['1', '2', '3', '4', '5'];

  String formatDate(DateTime? date) {
    if (date == null) return "Select Date";
    return "${date.day}/${date.month}/${date.year}";
  }

  Widget datePickerBox({
    required DateTime? date,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: () {},
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CustomBackButton(),

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
            child: const Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
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
                          selectedPriorityIndex =
                              val == true ? index : null;
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
                  onPressed: () {},
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

          const SizedBox(height: 50),

          // Custom Dialog
          ElevatedButton(
            onPressed: () {
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
                MaterialPageRoute(builder: (context) => DashboardPage()),
              );
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

          const SizedBox(height: 15),

          // Cancel
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(260, 40),
              backgroundColor: const Color(0XFF7B7B7B),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text(
              'CANCEL',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 21),
            ),
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
  final Image? image;

  const CustomDialog({
    super.key,
    required this.title,
    required this.message,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Material(
        color: Colors.black.withOpacity(0.3),
        child: Center(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              width: 350,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 110,
                    child: image ??
                        Image.asset(
                          "assets/img/COZY_TASK_LOGO.png",
                          fit: BoxFit.contain,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0XFF004463),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
