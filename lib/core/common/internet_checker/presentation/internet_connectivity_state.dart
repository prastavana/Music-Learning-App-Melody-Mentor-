// presentation/cubit/internet_connectivity_state.dart
part of 'internet_connectivity_cubit.dart';

abstract class InternetConnectivityState extends Equatable {
  const InternetConnectivityState();

  @override
  List<Object> get props => [];
}

class InternetConnectivityInitial extends InternetConnectivityState {}

class InternetConnectivityLoading extends InternetConnectivityState {}

class InternetConnectivityLoaded extends InternetConnectivityState {
  final bool isConnected;

  const InternetConnectivityLoaded({required this.isConnected});

  @override
  List<Object> get props => [isConnected];
}

class InternetConnectivityError extends InternetConnectivityState {
  final Failure failure;

  const InternetConnectivityError({required this.failure});

  @override
  List<Object> get props => [failure];
}
