part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class LoadCoursesAndBatches extends RegisterEvent {}

class RegisterStudent extends RegisterEvent {
  final BuildContext context;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String confirmPassword;

  const RegisterStudent({
    required this.context,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object> get props =>
      [context, firstName, lastName, email, password, confirmPassword];
}
