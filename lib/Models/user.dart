class User {
  static const colId = 'id';
  static const colName = 'name';
  static const colEmail = 'email';
  static const colPassword = 'password';

  User({this.id, this.name, this.email, this.password});

  int id;
  String name;
  String email;
  String password;

  User.fromMap(Map<String, dynamic> map) {
    id = map[colId];
    name = map[colName];
    email = map[colEmail];
    password = map[colPassword];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      colName: name,
      colEmail: email,
      colPassword: password
    };
    if (id != null) map[colId] = id;
    return map;
  }

}
