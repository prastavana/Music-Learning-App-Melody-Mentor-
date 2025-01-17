import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/common/snackbar/my_snackbar.dart';
import '../../../../dashboard/presentation/view_model/dashboard_cubit.dart';
import '../../../domain/use_case/login_usecase.dart';
import '../signup/register_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final RegisterBloc _registerBloc;
  final DashboardCubit _dashboardCubit;
  final LoginUseCase _loginUseCase;

  LoginBloc({
    required RegisterBloc registerBloc,
    required DashboardCubit dashboardCubit,
    required LoginUseCase loginUseCase,
  })  : _registerBloc = registerBloc,
        _dashboardCubit = dashboardCubit,
        _loginUseCase = loginUseCase,
        super(LoginState.initial()) {
    on<NavigateRegisterScreenEvent>(
      (event, emit) {
        // Navigation logic is now moved to UI
      },
    );

    on<LoginStudentEvent>(
      (event, emit) async {
        emit(state.copyWith(isLoading: true));

        final result = await _loginUseCase(
          LoginParams(
            email: event.email,
            password: event.password,
          ),
        );

        result.fold(
          (failure) {
            emit(state.copyWith(isLoading: false, isSuccess: false));
            showMySnackBar(
              context: event.context,
              message: failure.message ?? "Invalid Credentials",
              color: Colors.red,
            );
          },
          (token) {
            emit(state.copyWith(isLoading: false, isSuccess: true));
            // Remove the navigation here
          },
        );
      },
    );
  }
}
