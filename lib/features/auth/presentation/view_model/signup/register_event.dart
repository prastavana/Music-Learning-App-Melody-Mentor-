part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class LoadImage extends RegisterEvent {
  final File file;

  const LoadImage({
    required this.file,
  });
}

class RegisterStudent extends RegisterEvent {
  final BuildContext context;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String confirmPassword;
  final String? image;

  const RegisterStudent({
    required this.context,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    this.image,
  });
}
