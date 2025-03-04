import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object?> get props => [message]; // Corrected props type
}

class LocalDatabaseFailure extends Failure {
  const LocalDatabaseFailure({required super.message});
}

class RemoteDatabaseFailure extends Failure {
  const RemoteDatabaseFailure({required super.message});
}

class ApiFailure extends Failure {
  final int? statusCode;
  const ApiFailure({
    this.statusCode,
    required super.message,
  });

  @override
  List<Object?> get props => [message, statusCode]; // Added statusCode to props
}

class SharedPrefsFailure extends Failure {
  const SharedPrefsFailure({
    required super.message,
  });
}

class NetworkFailure extends Failure {
  //Added Network Failure here
  const NetworkFailure({required super.message});
}
