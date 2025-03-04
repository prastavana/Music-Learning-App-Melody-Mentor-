import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../error/failure.dart';
import '../domain/internet_checker.dart'; // Corrected import path

part 'internet_connectivity_state.dart';

class InternetConnectivityCubit extends Cubit<InternetConnectivityState> {
  final InternetChecker internetChecker;

  InternetConnectivityCubit(this.internetChecker)
      : super(InternetConnectivityInitial());

  Future<void> checkConnectivity() async {
    emit(InternetConnectivityLoading());
    final result = await internetChecker();
    result.fold(
      (failure) => emit(InternetConnectivityError(failure: failure)),
      (isConnected) =>
          emit(InternetConnectivityLoaded(isConnected: isConnected)),
    );
  }

  void monitorConnectivity() {
    internetChecker.networkInfo.onConnectivityChanged.listen((isConnected) {
      emit(InternetConnectivityLoaded(isConnected: isConnected));
    });
  }
}
