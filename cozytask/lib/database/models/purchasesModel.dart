class Purchases {
  int? id, userid, prodid;
  String date;

  Purchases({
    this.id,
    this.userid,
    this.prodid,
    required this.date
  });

  Map<String, dynamic> toMap() {
    return {
      'PUR_ID': id,
      'PUR_PurchasedAt': date,
      'USER_ID': userid,
      'PROD_ID': prodid
    };
  }

  static Purchases fromMap(Map<String, dynamic> map) {
    return Purchases(
      id: map['PUR_ID'],
      date: map['PUR_PurchasedAt'],
      userid: map['USER_ID'],
      prodid: map['PROD_ID'],
    );
  }
}
