class UserModel {
  final int id;
  final String fullName;
  final String phone;
  final String email;
  final String password;
  final String role;

  UserModel({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.email,
    required this.password,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      fullName: json['full_name'],
      phone: json['phone'],
      email: json['email'],
      password: json['password'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'phone': phone,
      'email': email,
      'password': password,
      'role': role,
    };
  }
}
