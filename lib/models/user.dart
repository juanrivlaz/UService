class User {
  int id;
  String name;
  String lastName;
  String username;
  String dmsCode;
  int agencyId;
  int rolId;
  
  User() {
    this.id = 0;
    this.name = '';
    this.lastName = '';
    this.username = '';
    this.dmsCode = '';
    this.agencyId = 0;
    this.rolId = 0;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    User user = new User();

    user.id = int.parse((json['id'] ?? 0).toString());
    user.name = json['name'] ?? '';
    user.lastName = json['last_name'] ?? '';
    user.username = json['username'] ?? '';
    user.dmsCode = json['dms_code'] ?? '';
    user.agencyId = int.parse((json['agency_id'] ?? 0).toString());
    user.rolId = int.parse((json['rol_id'] ?? 0).toString());

    return user;
  }
}