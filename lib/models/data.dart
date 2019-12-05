class User {
  int id;
  String name;
  String username;
  String email;
  String phone;
  String website;

  User(int id, String name, String username, String email, String phone, String website) {
    this.id = id;
    this.name = name;
    this.username = username;
    this.email = email;
    this.phone = phone;
    this.website = website;
  }

  User.fromJson(Map json)
    : id = json['id'],
      name = json['name'],
      username = json['username'],
      email = json['email'],
      phone = json['phone'],
      website = json['website'];

  Map toJson() {
    return {'id': id, 'name': name, 'username': username, 'email': email, 'phone': phone, 'website': website};
  }
}