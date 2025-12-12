import 'dart:typed_data';

class Purchases {
  int? id, userid, prodid;
  Uint8List? photo;

  Purchases({
    this.id,
    this.userid,
    this.prodid,
    required this.photo
  });

  Map<String, dynamic> toMap() {
    return {
      'PUR_ID': id,
      'PUR_Photo': photo,
      'USER_ID': userid,
      'PROD_ID': prodid
    };
  }

  static Purchases fromMap(Map<String, dynamic> map) {
    return Purchases(
      id: map['PUR_ID'],
      photo: map['PUR_Photo'],
      userid: map['USER_ID'],
      prodid: map['PROD_ID'],
    );
  }
}
