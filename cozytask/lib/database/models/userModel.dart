class User {
  int? id, petid;
  int points, year;
  String name, password, email, university, loginstatus;

  User({
    this.id,
    this.petid,
    required this.points,
    required this.year,
    required this.name,
    required this.password,
    required this.email,
    required this.university,
    required this.loginstatus,
  });

  Map<String, dynamic> toMap() {
    return {
      'USER_ID': id,
      'USER_Name': name,
      'USER_Password': password,
      'USER_Email': email,
      'USER_University': university,
      'USER_YearLevel': year,
      'USER_Points': points,
      'USER_LoginStatus': loginstatus,
      'USER_SelectedPetID': petid,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
      id: map['USER_ID'],
      name: map['USER_Name'],
      password: map['USER_Password'],
      email: map['USER_Email'],
      university: map['USER_University'],
      year: map['USER_YearLevel'],
      points: map['USER_Points'],
      loginstatus: map['USER_LoginStatus'],
      petid: map['USER_SelectedPetID'],
    );
  }
}
