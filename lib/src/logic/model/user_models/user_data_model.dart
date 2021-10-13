import 'dart:convert';

class UserResponseModel {
  String? username;
  String? password;
  String? email;
  UserResponseModel({
    this.username,
    this.password,
    this.email,
  });

  UserResponseModel copyWith({
    String? username,
    String? password,
    String? email,
  }) {
    return UserResponseModel(
      username: username ?? this.username,
      password: password ?? this.password,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'email': email,
    };
  }

  factory UserResponseModel.fromMap(Map<String, dynamic> map) {
    return UserResponseModel(
      username: map['username'],
      password: map['password'],
      email: map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserResponseModel.fromJson(String source) =>
      UserResponseModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'UserResponseModel(username: $username, password: $password, email: $email)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserResponseModel &&
        other.username == username &&
        other.password == password &&
        other.email == email;
  }

  @override
  int get hashCode => username.hashCode ^ password.hashCode ^ email.hashCode;
}
