import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_learning_app/features/session/presentation/view_model/session_event.dart';
import 'package:music_learning_app/features/session/presentation/view_model/session_state.dart';

import '../../domain/use_case/get_session_usecase.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final GetSessionsUseCase getSessions;

  SessionBloc({required this.getSessions}) : super(SessionInitial()) {
    on<LoadSessionsEvent>((event, emit) async {
      emit(SessionLoading());
      final result = await getSessions(instrument: event.instrument);
      result.fold(
        (failure) => emit(SessionError(failure.message)),
        (sessions) => emit(SessionLoaded(sessions)),
      );
    });
  }
}
