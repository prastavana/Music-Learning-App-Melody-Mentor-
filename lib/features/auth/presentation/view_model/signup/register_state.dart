part of 'register_bloc.dart';

class RegisterState {
  final bool isLoading;
  final bool isSuccess;
  final String? imageName;

  RegisterState({
    required this.isLoading,
    required this.isSuccess,
    this.imageName,
  });

  // Initial state constructor
  RegisterState.initial()
      : isLoading = false,
        isSuccess = false,
        imageName = null;

  // CopyWith method to update state
  RegisterState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? imageName, // Add imageName here to allow updating it
  }) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      imageName: imageName ?? this.imageName, // Ensure imageName can be updated
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, imageName];
}
