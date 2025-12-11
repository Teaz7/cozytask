class Reward {
  int? id, taskid, userid;
  int points;

  Reward({
    this.id,
    this.taskid,
    this.userid,
    required this.points
  });

  Map<String, dynamic> toMap() {
    return {
      'REWARD_ID': id,
      'REWARD_Points': points,
      'TASK_ID': taskid,
      'USER_ID': userid
    };
  }

  static Reward fromMap(Map<String, dynamic> map) {
    return Reward(
      id: map['REWARD_ID'],
      points: map['REWARD_Points'],
      taskid: map['TASK_ID'],
      userid: map['USER_ID']
    );
  }
}
