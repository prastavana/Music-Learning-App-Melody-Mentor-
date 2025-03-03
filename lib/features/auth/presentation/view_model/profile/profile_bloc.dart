import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_learning_app/features/auth/domain/entity/auth_entity.dart';
import 'package:music_learning_app/features/auth/domain/use_case/get_profile_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;

  ProfileBloc(this.getProfileUseCase) : super(ProfileInitial()) {
    on<FetchProfileEvent>((event, emit) async {
      // Added on handler
      emit(ProfileLoading());
      final result = await getProfileUseCase(event.token);
      result.fold(
        (failure) => emit(ProfileError(failure.message)),
        (user) => emit(ProfileLoaded(user)),
      );
    });
  }
}
