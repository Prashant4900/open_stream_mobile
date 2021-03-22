class UserDetailModel {
  UserDetailModel({this.email, this.name, this.username, this.id, this.number});

  final String id;
  final String username;
  final String name;
  final String email;
  final String number;

  factory UserDetailModel.fromJson(Map<String, dynamic> json) {
    return UserDetailModel(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
      name: json['name'],
      number: json['number'],
    );
  }
}
