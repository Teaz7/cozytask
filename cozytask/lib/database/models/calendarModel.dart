class Calendar {
  int? id, userid;
  int numoftask;

  Calendar({
    this.id,
    this.userid,
    required this.numoftask,
  });

  Map<String, dynamic> toMap() {
    return {
      'CAL_ID': id,
      'CAL_NumOfTask': numoftask,
      'USER_ID': userid
    };
  }

  static Calendar fromMap(Map<String, dynamic> map) {
    return Calendar(
      id: map['CAL_ID'],
      numoftask: map['CAL_NumOfTask'],
      userid: map['USER_ID']
    );
  }
}
