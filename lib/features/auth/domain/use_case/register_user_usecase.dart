import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entity/auth_entity.dart';
import '../repository/auth_repository.dart';

class RegisterUserParams extends Equatable {
  final String firstName; // updated to firstName
  final String lastName; // updated to lastName
  final String email; // updated to email
  final String password;
  final String confirmPassword; // added confirmPassword
  final String? image;

  const RegisterUserParams({
    required this.firstName, // updated to firstName
    required this.lastName, // updated to lastName
    required this.email, // updated to email
    required this.password,
    required this.confirmPassword,
    this.image,
  });

  // Initial constructor
  const RegisterUserParams.initial({
    required this.firstName, // updated to firstName
    required this.lastName, // updated to lastName
    required this.email, // updated to email
    required this.password,
    required this.confirmPassword, // added confirmPassword
    required this.image,
  });

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        email,
        password,
        confirmPassword,
        image
      ]; // updated props
}

class RegisterUseCase implements UsecaseWithParams<void, RegisterUserParams> {
  final IAuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final authEntity = AuthEntity(
      firstName: params.firstName, // updated to firstName
      lastName: params.lastName, // updated to lastName
      email: params.email, // updated to email
      password: params.password,
      confirmPassword: params.confirmPassword, // added confirmPassword
      image: params.image,
    );
    return repository.registerStudent(authEntity);
  }
}
