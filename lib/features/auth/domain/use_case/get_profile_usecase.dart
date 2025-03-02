// get_profile_usecase.dart
import 'package:dartz/dartz.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entity/auth_entity.dart';
import '../repository/auth_repository.dart';

class GetProfileUseCase implements UsecaseWithParams<AuthEntity, String> {
  final IAuthRepository repository;

  GetProfileUseCase(this.repository);

  @override
  Future<Either<Failure, AuthEntity>> call(String token) async {
    return repository.getCurrentUser(token);
  }
}
