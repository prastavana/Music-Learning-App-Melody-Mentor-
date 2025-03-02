// profile_bloc.dart
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_learning_app/features/auth/domain/entity/auth_entity.dart';
import 'package:music_learning_app/features/auth/domain/use_case/get_profile_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;

  ProfileBloc(this.getProfileUseCase) : super(ProfileInitial());

  Future<void> fetchProfile(String token) async {
    emit(ProfileLoading());
    final result = await getProfileUseCase(token);
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (user) => emit(ProfileLoaded(user)),
    );
  }
}
