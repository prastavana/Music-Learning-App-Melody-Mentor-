import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String firstName; // updated field
  final String lastName; // updated field
  final String email; // updated field
  final String password; // updated field
  final String confirmPassword; // updated field
  final String? image;

  const AuthEntity({
    this.userId,
    required this.firstName, // updated field
    required this.lastName, // updated field
    required this.email, // updated field
    required this.password, // updated field
    required this.confirmPassword, // updated field
    this.image,
  });

  @override
  List<Object?> get props =>
      [userId, firstName, lastName, email, password, confirmPassword, image];
}
