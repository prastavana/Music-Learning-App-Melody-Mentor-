// core/common/failure.dart
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]);

  @override
  List<Object> get props => properties as List<Object>;
}

class NetworkFailure extends Failure {}

// Add other failure types as needed
