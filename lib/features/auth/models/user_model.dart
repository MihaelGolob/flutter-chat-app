import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String username;

  const User({required this.id, required this.email, required this.username});

  @override
  List<Object?> get props => [id, email, username];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'username': username,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      email: map['email'],
      username: map['username'],
    );
  }
}
