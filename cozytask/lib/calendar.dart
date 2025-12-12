import 'package:cozytask/components/backbutton.dart';
import 'package:cozytask/components/minitaskwidget.dart';
import 'package:cozytask/database/dbHelper.dart';
import 'package:cozytask/database/models/taskModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatelessWidget {
  final int? userid;
  const CalendarPage({super.key, required this.userid});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Calendar(userid: userid,)
        ),
      ),
    );
  }
}

class Calendar extends StatefulWidget {
  final int? userid;
  const Calendar({super.key, required this.userid});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  List<Task> tasklist = [];
  List<Task> selectedTasks = [];
  DateTime? selectedDay;

  final ValueNotifier<DateTime> focusedDay = ValueNotifier(DateTime.now());
  final ValueNotifier<String> selectedMonth =
      ValueNotifier(DateFormat('MMMM').format(DateTime.now()));
  final ValueNotifier<int> selectedYear =
      ValueNotifier(DateTime.now().year);
  final List<String> months = [
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
  ];

  void _openTasks(DateTime date) async {
    String formattedDate = "${date.day}/${date.month}/${date.year}";
    final tasks = await DBHelper.instance.getTasksByDate(widget.userid, formattedDate);
    
    setState(() {
      selectedTasks = tasks;
    });
    
    if (!mounted) return;
    
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: StatefulBuilder(
          builder: (context, setDialogState) {
            return _overlayTasks(setDialogState);
          },
        ),
      )
    );
  }

  Widget _overlayTasks(StateSetter setDialogState) => SizedBox(
    height: 700,
    child: Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        children: <Widget>[
          MiniTaskWidget(tasklist: selectedTasks, userid: widget.userid, dashboard: true)
        ],
      )
    ),
  );

  DateTime? _parseEndDate(String? enddate) {
    if (enddate == null || enddate == "Select Date") return null;
    try {
      final parts = enddate.split('/');
      if (parts.length == 3) {
        return DateTime(
          int.parse(parts[2]), // year
          int.parse(parts[1]), // month
          int.parse(parts[0]), // day
        );
      } 
    } catch (e) {
      print("Error parsing date: $e");
    }
    return null;
  }

  bool _hasTasksOnDate(DateTime date) {
    return tasklist.any((task) {
    if (task.progress == 100) return false;
    
    final taskDate = _parseEndDate(task.dateend);
    if (taskDate == null) return false;
    return taskDate.year == date.year &&
          taskDate.month == date.month &&
          taskDate.day == date.day;
  });
  }

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
    // Debug prints
    print("=== LOADED ${tasklist.length} TASKS ===");
    for (var task in tasklist) {
      print("Task: ${task.name}");
      print("  EndDate String: '${task.dateend}'");
      print("  Parsed Date: ${_parseEndDate(task.dateend)}");
    }
  }
    
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: CustomBackButton(userid: widget.userid,),
          ),
        Image.asset(
          'assets/img/COZY_TASK_FULL_LOGO.png',
          height: 120,
        ),
        const SizedBox(height: 5),
        const Text(
          "2025 CALENDAR",
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w700,
            color: Color(0xFF68A3BC),
          ),
        ),
        const SizedBox(height: 20),
        ValueListenableBuilder(
          valueListenable: focusedDay,
          builder: (context, fDay, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
             
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFF0B4A6F),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: ValueListenableBuilder(
                    valueListenable: selectedMonth,
                    builder: (context, monthVal, _) {
                      return DropdownButton<String>(
                        dropdownColor: Color(0xFF0B4A6F),
                        value: monthVal,
                        underline: SizedBox(),
                        iconEnabledColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                        items: months.map((String month) {
                          return DropdownMenuItem(
                            value: month,
                            child: Text(month,
                                style: TextStyle(color: Colors.white)),
                          );
                        }).toList(),
                        onChanged: (val) {
                          selectedMonth.value = val!;
                          focusedDay.value = DateTime(
                            selectedYear.value,
                            months.indexOf(val) + 1,
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFF0B4A6F),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: ValueListenableBuilder(
                    valueListenable: selectedYear,
                    builder: (context, yearVal, _) {
                      return DropdownButton<int>(
                        dropdownColor: Color(0xFF0B4A6F),
                        value: yearVal,
                        underline: SizedBox(),
                        iconEnabledColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                        items: List.generate(20, (i) => 2020 + i)
                            .map((year) {
                          return DropdownMenuItem(
                            value: year,
                            child: Text(
                              "$year",
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }).toList(),
                        onChanged: (val) {
                          selectedYear.value = val!;
                          focusedDay.value = DateTime(
                            val,
                            months.indexOf(selectedMonth.value) + 1,
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    focusedDay.value = DateTime.now();
                    selectedYear.value = DateTime.now().year;
                    selectedMonth.value =
                        DateFormat('MMMM').format(DateTime.now());
                  },
                  child: Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(
                        horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: Color(0xFF0B4A6F),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text("Today",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 20),

        ValueListenableBuilder(
          valueListenable: focusedDay,
          builder: (context, fDay, _) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border:
                    Border.all(color: Color(0xFF0B4A6F), width: 3),
                borderRadius: BorderRadius.circular(16),
              ),
              child: TableCalendar(
                locale: "en_US",
                rowHeight: 60,
                focusedDay: fDay,
                firstDay: DateTime.utc(2020),
                lastDay: DateTime.utc(2035),
                headerVisible: false,
                selectedDayPredicate: (day) => isSameDay(selectedDay, day),
                onDaySelected: (selected, focused) {
                  if (_hasTasksOnDate(selected)) {
                    setState(() {
                      selectedDay = selected;
                    });
                    _openTasks(selected);
                  }
                },
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Color(0xFF0B4A6F),
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Color(0xFF4A90A4),
                  ),
                ),
                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0B4A6F),
                  ),
                  weekendStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0B4A6F),
                  ),
                ),

                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, day, focusedDay) {
                    if (_hasTasksOnDate(day)) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDay = day;
                          });
                          _openTasks(day);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Color(0xFF68A3BC),
                          ),
                          child: Center(
                            child: Text(
                              '${day.day}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    }
                    return null;
                  },

                  todayBuilder: (context, day, focusedDay) {
                    if (_hasTasksOnDate(day)) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDay = day;
                          });
                          _openTasks(day);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Color(0xFF004463),
                          ),
                          child: Center(
                            child: Text(
                              '${day.day}',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    return null;
                  },

                  outsideBuilder: (context, day, focusedDay) {
                    if (_hasTasksOnDate(day)) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDay = day;
                          });
                          _openTasks(day);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Color(0xFF004463).withOpacity(0.5),
                          ),
                          child: Center(
                            child: Text(
                              '${day.day}',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ),
                        ),
                      );
                    }
                    return null;
                  },
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            GestureDetector(
              onTap: () {
                focusedDay.value = DateTime(
                  focusedDay.value.year,
                  focusedDay.value.month - 1,
                  1,
                );
                selectedMonth.value = months[focusedDay.value.month - 1];
                selectedYear.value = focusedDay.value.year;
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: Color(0xFF0B4A6F),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text("≪  Previous Month",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                focusedDay.value = DateTime(
                  focusedDay.value.year,
                  focusedDay.value.month + 1,
                  1,
                );
                selectedMonth.value = months[focusedDay.value.month - 1];
                selectedYear.value = focusedDay.value.year;
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: Color(0xFF0B4A6F),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text("Next Month  ≫",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}