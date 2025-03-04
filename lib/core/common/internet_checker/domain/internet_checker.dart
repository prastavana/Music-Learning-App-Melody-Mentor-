// core/common/internet_checker/internet_checker.dart
import 'package:dartz/dartz.dart';
import 'package:music_learning_app/core/common/failure.dart';
import 'package:music_learning_app/core/network/network_info.dart';

class InternetChecker {
  final NetworkInfo networkInfo;

  InternetChecker(this.networkInfo);

  Future<Either<Failure, bool>> call() async {
    try {
      final isConnected = await networkInfo.isConnected;
      return Right(isConnected);
    } on Exception {
      return Left(NetworkFailure()); // Or a more specific failure
    }
  }
}
