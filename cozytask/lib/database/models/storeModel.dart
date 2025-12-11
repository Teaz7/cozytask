class Store {
  int? id, userid;
  int num;

  Store({
    this.id,
    this.userid,
    required this.num
  });

  Map<String, dynamic> toMap() {
    return {
      'STORE_ID': id,
      'STORE_NumOfProduct': num,
      'USER_ID': userid
    };
  }

  static Store fromMap(Map<String, dynamic> map) {
    return Store(
      id: map['STORE_ID'],
      num: map['STORE_NumOfProduct'],
      userid: map['USER_ID']
    );
  }
}
