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
  final String name;
  final String email;
  final String password;
  final String? profilePicture;

  const RegisterStudent({
    required this.context,
    required this.name,
    required this.email,
    required this.password,
    this.profilePicture,
  });
}
