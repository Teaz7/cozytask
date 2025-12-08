class Task {
  int? id, calid, userid;
  int progress;
  String name, description, priority, status, datestart, dateend;

  Task({
    this.id,
    this.calid,
    this.userid,
    required this.progress,
    required this.name,
    required this.description,
    required this.priority,
    required this.status,
    required this.datestart,
    required this.dateend
  });

  Map<String, dynamic> toMap() {
    return {
      'TASK_ID': id,
      'TASK_Name': name,
      'TASK_Description': description,
      'TASK_PriorityClass': priority,
      'TASK_Status': status,
      'TASK_DateStart': datestart,
      'TASK_DateFinish': dateend,
      'TASK_Progress': progress,
      'CAL_ID': calid,
      'USER_ID': userid
    };
  }

  static Task fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['TASK_ID'],
      name: map['TASK_Name'],
      description: map['TASK_Description'],
      priority: map['TASK_PriorityClass'],
      status: map['TASK_Status'],
      datestart: map['TASK_DateStart'],
      dateend: map['TASK_DateFinish'],
      progress: map['TASK_Progress'],
      calid: map['CAL_ID'],
      userid: map['USER_ID']
    );
  }
}