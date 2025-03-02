import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/data_source/tuner_local_data_source.dart';
import '../../data/repository/tuner_repository_impl.dart';
import '../../domain/use_case/analyze_frequency_usecase.dart';
import '../../domain/use_case/get_closest_note_usecase.dart';
import '../../domain/use_case/start_recording_usecase.dart';
import '../../domain/use_case/stop_recording_usecase.dart';
import '../view_model/tuner_bloc.dart';
import '../view_model/tuner_event.dart';
import '../view_model/tuner_state.dart';

class TunerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TunerBloc(
        startRecordingUseCase:
            StartRecordingUseCase(TunerRepositoryImpl(TunerLocalDataSource())),
        stopRecordingUseCase:
            StopRecordingUseCase(TunerRepositoryImpl(TunerLocalDataSource())),
        analyzeFrequencyUseCase: AnalyzeFrequencyUseCase(
            TunerRepositoryImpl(TunerLocalDataSource())),
        getClosestNoteUseCase:
            GetClosestNoteUseCase(TunerRepositoryImpl(TunerLocalDataSource())),
      ),
      child: TunerView(),
    );
  }
}

class TunerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tuner')),
      body: Center(
        child: BlocBuilder<TunerBloc, TunerState>(
          builder: (context, state) {
            if (state is TunerLoading) {
              return CircularProgressIndicator();
            } else if (state is TunerLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      'Frequency: ${state.frequency?.toStringAsFixed(2) ?? 'N/A'} Hz'),
                  Text(
                      'Closest Note: ${state.closestNote?.name ?? 'N/A'} (${state.closestNote?.frequency.toStringAsFixed(2) ?? 'N/A'} Hz)'),
                  DropdownButton<String>(
                    value: context.read<TunerBloc>().currentInstrument,
                    onChanged: (value) {
                      context
                          .read<TunerBloc>()
                          .add(InstrumentChangedEvent(value!));
                    },
                    items: ['guitar', 'ukulele'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<TunerBloc>().add(StartRecordingEvent());
                    },
                    child: Text('Start Recording'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<TunerBloc>().add(StopRecordingEvent());
                    },
                    child: Text('Stop Recording'),
                  ),
                ],
              );
            } else if (state is TunerError) {
              return Text('Error occurred');
            } else {
              return Column(
                children: [
                  DropdownButton<String>(
                    value: context.read<TunerBloc>().currentInstrument,
                    onChanged: (value) {
                      context
                          .read<TunerBloc>()
                          .add(InstrumentChangedEvent(value!));
                    },
                    items: ['guitar', 'ukulele'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<TunerBloc>().add(StartRecordingEvent());
                    },
                    child: Text('Start Recording'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<TunerBloc>().add(StopRecordingEvent());
                    },
                    child: Text('Stop Recording'),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
