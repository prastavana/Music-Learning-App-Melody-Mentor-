import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String name; // updated field
  final String email; // updated field
  final String password; // updated field
  final String? profilePicture;

  const AuthEntity({
    this.userId,
    required this.name, // updated field
    required this.email, // updated field
    required this.password, // updated field
    this.profilePicture,
  });

  @override
  List<Object?> get props => [userId, name, email, password, profilePicture];
}
