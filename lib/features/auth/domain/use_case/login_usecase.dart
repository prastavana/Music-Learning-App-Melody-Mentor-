import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../repository/auth_repository.dart';

class LoginParams extends Equatable {
  final String email; // updated field
  final String password; // updated field

  const LoginParams({
    required this.email, // updated field
    required this.password, // updated field
  });

  // Initial Constructor
  const LoginParams.initial()
      : email = '', // updated field
        password = ''; // updated field

  @override
  List<Object> get props => [email, password];
}

class LoginUseCase implements UsecaseWithParams<String, LoginParams> {
  final IAuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(LoginParams params) {
    // IF api then store token in shared preferences
    return repository.loginStudent(
        params.email, params.password); // updated field
  }
}
