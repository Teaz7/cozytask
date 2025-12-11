class SubtTask {
  int? id, taskid;
  String name, status;

  SubtTask({
    this.id,
    this.taskid,
    required this.name,
    required this.status
  });

  Map<String, dynamic> toMap() {
    return {
      'SUBTASK_ID': id,
      'SUBTASK_Name': name,
      'SUBTASK_Status': status,
      'TASK_ID': taskid
    };
  }

  static SubtTask fromMap(Map<String, dynamic> map) {
    return SubtTask(
      id: map['SUBTASK_ID'],
      name: map['SUBTASK_Name'],
      status: map['SUBTASK_Status'],
      taskid: map['TASK_ID']
    );
  }
}
