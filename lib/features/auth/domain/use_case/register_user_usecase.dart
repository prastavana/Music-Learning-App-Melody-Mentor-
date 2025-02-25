import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entity/auth_entity.dart';
import '../repository/auth_repository.dart';

class RegisterUserParams extends Equatable {
  final String name; // updated to firstName
  final String email; // updated to email
  final String password;
  final String? profilePicture;

  const RegisterUserParams({
    required this.name, // updated to firstName
    required this.email, // updated to email
    required this.password,
    this.profilePicture,
  });

  // Initial constructor
  const RegisterUserParams.initial({
    required this.name, // updated to firstName
    required this.email, // updated to email
    required this.password,
    required this.profilePicture,
  });

  @override
  List<Object?> get props =>
      [name, email, password, profilePicture]; // updated props
}

class RegisterUseCase implements UsecaseWithParams<void, RegisterUserParams> {
  final IAuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final authEntity = AuthEntity(
      name: params.name, // updated to firstName
      email: params.email, // updated to email
      password: params.password,
      profilePicture: params.profilePicture,
    );
    return repository.registerStudent(authEntity);
  }
}
