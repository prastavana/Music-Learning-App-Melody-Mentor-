// core/common/internet_checker/internet_checker.dart
import 'package:dartz/dartz.dart';

import '../../../error/failure.dart';
import '../data/network_info.dart';

class InternetChecker {
  final NetworkInfo networkInfo;

  InternetChecker(this.networkInfo);

  Future<Either<Failure, bool>> call() async {
    try {
      final isConnected = await networkInfo.isConnected;
      return Right(isConnected);
    } on Exception {
      return Left(NetworkFailure(message: '')); // Or a more specific failure
    }
  }
}
