class UserModel {
  final int id;
  final String role;
  final String name;
  final String email;
  final String password;
  final String createdAt;
  final String updatedAt;

  UserModel({
    required this.id,
    required this.role,
    required this.name,
    required this.email,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      role: json['role'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'role': role,
      'name': name,
      'email': email,
      'password': password,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
