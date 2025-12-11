import 'package:cozytask/components/backbutton.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatelessWidget {
  final int? userid;
  const CalendarPage({super.key, required this.userid});

  @override
  Widget build(BuildContext context) {

    final ValueNotifier<DateTime> focusedDay = ValueNotifier(DateTime.now());
    final ValueNotifier<String> selectedMonth =
        ValueNotifier(DateFormat('MMMM').format(DateTime.now()));
    final ValueNotifier<int> selectedYear =
        ValueNotifier(DateTime.now().year);

    final List<String> months = [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [

              const SizedBox(height: 20),

              Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: CustomBackButton(userid: userid,),
                ),

              Image.asset(
                'assets/img/COZY_TASK_FULL_LOGO.png',
                height: 120,
              ),

              const SizedBox(height: 5),

              const Text(
                "2025 CALENDAR",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0B4A6F),
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
                      rowHeight: 42,
                      focusedDay: fDay,
                      firstDay: DateTime.utc(2020),
                      lastDay: DateTime.utc(2035),
                      headerVisible: false,

                      calendarStyle: CalendarStyle(
                        todayDecoration: BoxDecoration(
                          color: Color(0xFF0B4A6F),
                          shape: BoxShape.circle,
                        ),
                        selectedDecoration: BoxDecoration(
                          color: Color(0xFF4A90A4),
                          shape: BoxShape.circle,
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
          ),
        ),
      ),
    );
  }
}
