class UserModel {
  final String name;
  final String username;
  final String email;
  final String? organisation;
  final String? role;

  UserModel({
    required this.name,
    required this.username,
    required this.email,
    required this.organisation,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      username: json['username'],
      email: json['email'],
      organisation: json['organisation'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'username': username,
      'email': email,
      'organisation': organisation,
      'role': role,
    };
  }
}
