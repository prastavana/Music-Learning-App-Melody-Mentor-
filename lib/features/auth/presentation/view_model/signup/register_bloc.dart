import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/common/snackbar/my_snackbar.dart';
import '../../../domain/use_case/register_user_usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterBloc({
    required RegisterUseCase registerUseCase,
  })  : registerUseCase = registerUseCase,
        super(RegisterState.initial()) {
    on<RegisterStudent>(_onRegisterEvent);
  }

  void _onRegisterEvent(
    RegisterStudent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await registerUseCase.call(RegisterUserParams(
      firstName: event.firstName,
      lastName: event.lastName,
      email: event.email,
      password: event.password,
      confirmPassword: event.confirmPassword,
    ));

    result.fold(
      (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
            context: event.context, message: "Registration Successful");
      },
    );
  }
}
