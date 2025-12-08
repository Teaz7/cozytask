class Reminder {
  int? id, taskid;
  String date, text;

  Reminder({
    this.id,
    this.taskid,
    required this.date,
    required this.text
  });

  Map<String, dynamic> toMap() {
    return {
      'REMIND_ID': id,
      'REMIND_Date': date,
      'REMIND_Text': text,
      'TASK_ID': taskid
    };
  }

  static Reminder fromMap(Map<String, dynamic> map) {
    return Reminder(
      id: map['REMIND_ID'],
      date: map['REMIND_Date'],
      text: map['REMIND_Text'],
      taskid: map['TASK_ID']
    );
  }
}
