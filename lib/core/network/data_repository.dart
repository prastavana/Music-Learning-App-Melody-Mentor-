// core/network/data_repository.dart
import 'package:dartz/dartz.dart';

import '../common/internet_checker/domain/internet_checker.dart';
import '../error/failure.dart';
import 'data_source.dart';
import 'local_data_source.dart';

class DataRepository<T> {
  final DataSource<T> remoteDataSource;
  final LocalDataSource<T>? localDataSource;
  final InternetChecker internetChecker;

  DataRepository(this.remoteDataSource, this.internetChecker,
      {this.localDataSource});

  Future<Either<Failure, T>> fetchData() async {
    final connectivityResult = await internetChecker();
    return connectivityResult.fold(
      (failure) => Left(failure),
      (isConnected) async {
        try {
          if (isConnected) {
            return Right(await remoteDataSource.getRemoteData());
          } else {
            if (localDataSource != null) {
              return Right(await localDataSource!.getLocalData());
            } else {
              return Left(NetworkFailure(message: 'No local data available.'));
            }
          }
        } catch (e) {
          return Left(NetworkFailure(message: e.toString()));
        }
      },
    );
  }
}
