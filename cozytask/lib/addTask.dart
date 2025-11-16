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
        body: Center(
          child: AddTask(),
        ),
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
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            const Icon(
              Icons.arrow_drop_down,
              color: Colors.black,
              size: 25,
            ),
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
          const Padding(padding: EdgeInsets.all(5)),

          // Back Button
          Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            child: Image.asset(
              'assets/icon/BackButton.png',
              height: 30,
            ),
          ),

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

          // Task Name Label
          Container(
            width: 400,
            alignment: Alignment.centerLeft,
            child: const Text(
              'Task Name',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Color(0XFF000000),
              ),
            ),
          ),

          // Task Name Field
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            width: 400,
            height: 50,
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: const Color(0XFFD8E8F4),
              ),
            ),
          ),

          // Description Label
          Container(
            width: 400,
            alignment: Alignment.centerLeft,
            child: const Text(
              'Description',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Color(0XFF000000),
              ),
            ),
          ),

          // Description Field
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            width: 400,
            child: TextField(
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: const Color(0XFFD8E8F4),
              ),
            ),
          ),

          const Padding(padding: EdgeInsets.all(5)),

          // Start & End date labels
          Container(
            padding: const EdgeInsets.only(left: 55),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Start Date:',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
                Text(
                  'End Date:',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Date 
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 55),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // START DATE
                datePickerBox(
                  date: startDate,
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      setState(() => startDate = picked);
                    }
                  },
                ),

                // END DATE
                datePickerBox(
                  date: endDate,
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      setState(() => endDate = picked);
                    }
                  },
                ),
              ],
            ),
          ),

          // Prioritization Label
          Container(
            width: 400,
            padding: const EdgeInsets.only(top: 15),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Prioritization',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Color(0XFF000000),
              ),
            ),
          ),

                   Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              for (var index = 0; index < priority.length; index++)
                Container(
                  padding: const EdgeInsets.only(left: 45),
                  child: Row(
                    children: [
                      Checkbox(
                        value: selectedPriorityIndex == index,
                        onChanged: (val) {
                          setState(() {
                            if (val == true) {
                              selectedPriorityIndex = index;
                            } else {
                              selectedPriorityIndex = null;
                            }
                          });
                        },
                        fillColor:
                            WidgetStateProperty.resolveWith<Color>((states) {
                          if (states.contains(WidgetState.selected)) {
                            return const Color(0XFF004463); 
                          }
                          return const Color.fromARGB(255, 255, 253, 253); 
                        }),
                      ),
                      Text(
                        priority[index],
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          const Padding(padding: EdgeInsets.all(5)),

          // Subtask 
          Container(
            padding: const EdgeInsets.only(left: 5),
            width: 405,
            height: 40,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Add Subtask...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: const Color(0XFFD8E8F4),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text(
                    '+',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Padding(padding: EdgeInsets.all(20)),

          // ADD TASK 
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(220, 40),
              backgroundColor: const Color(0XFF004463),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'ADD TASK',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 21,
              ),
            ),
          ),

          const Padding(padding: EdgeInsets.all(5)),

          // CANCEL 
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(220, 40),
              backgroundColor: const Color(0XFF7B7B7B),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'CANCEL',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 21,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
