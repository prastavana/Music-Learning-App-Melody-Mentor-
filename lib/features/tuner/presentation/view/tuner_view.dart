import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart'; // Import the necessary package for radial gauge

import '../../../../core/theme/colors.dart'; // Make sure AppColors is correctly imported
import '../view_model/tuner/tuner_bloc.dart';
import '../view_model/tunings/tunings_cubit.dart';

class TunerView extends StatelessWidget {
  const TunerView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetIt.instance.isRegistered<TunerBloc>()
              ? GetIt.instance<TunerBloc>()
              : TunerBloc(),
        ),
        BlocProvider(
          create: (context) => TuningsCubit(),
        ),
      ],
      child: const TunerPage(),
    );
  }
}

class TunerPage extends StatefulWidget {
  const TunerPage({super.key});

  @override
  State<TunerPage> createState() => _TunerPageState();
}

class _TunerPageState extends State<TunerPage> {
  late ThemeMode themeMode;

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    final result = await Permission.microphone.request();
    if (result.isGranted) {
      if (mounted) {
        context.read<TunerBloc>().add(StartRecordingEvent());
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Microphone permission denied")),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  void dispose() {
    if (mounted) {
      context.read<TunerBloc>().add(StopRecordingEvent());
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use ThemeMode correctly (Brightness check)
    themeMode = Theme.of(context).brightness == Brightness.light
        ? ThemeMode.light
        : ThemeMode.dark;

    return WillPopScope(
      onWillPop: () async {
        context.read<TunerBloc>().add(StopRecordingEvent());
        return true;
      },
      child: Scaffold(
        backgroundColor: themeMode == ThemeMode.light
            ? AppColors.lightNavBarBackground
            : AppColors.darkNavBarBackground,
        body: BlocBuilder<TunerBloc, TunerState>(
          builder: (context, state) {
            return Center(
              child: Column(
                children: [
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          context.read<TunerBloc>().add(StopRecordingEvent());
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          size: 40,
                          color: AppColors.lightNavBarSelected,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        state is RecordingState ? state.note : "",
                        style: TextStyle(
                          color: (state is RecordingState &&
                                  state.status == "In Tune")
                              ? AppColors.successColor
                              : AppColors.warningColor,
                          fontSize: 60.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.info_outline,
                          color: themeMode == ThemeMode.light
                              ? AppColors.lightAppBarText
                              : AppColors.darkAppBarText,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  _buildRadialGauge(state),
                  const Spacer(),
                  _buildTuningOption(),
                  const Spacer(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildRadialGauge(TunerState state) {
    double gaugeValue = 50;
    if (state is RecordingState) {
      switch (state.status) {
        case "waytoolow":
          gaugeValue = 20;
          break;
        case "toolow":
          gaugeValue = 40;
          break;
        case "In Tune":
          gaugeValue = 50;
          break;
        case "toohigh":
          gaugeValue = 60;
          break;
        case "waytoohigh":
          gaugeValue = 80;
          break;
      }
    }

    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          showLabels: false,
          showAxisLine: false,
          showTicks: false,
          minimum: 0,
          maximum: 100,
          ranges: <GaugeRange>[
            GaugeRange(
              startValue: 0,
              endValue: 50,
              color: AppColors.warningColor,
            ),
            GaugeRange(
              startValue: 50,
              endValue: 100,
              color: AppColors.successColor,
            ),
          ],
          pointers: <GaugePointer>[
            NeedlePointer(
              value: gaugeValue,
              needleColor: themeMode == ThemeMode.light
                  ? AppColors.lightAppBarText
                  : AppColors.darkAppBarText,
              enableAnimation: true,
              knobStyle: KnobStyle(
                color: themeMode == ThemeMode.light
                    ? AppColors.lightAppBarText
                    : AppColors.darkAppBarText,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTuningOption() {
    return BlocBuilder<TuningsCubit, TuningsState>(
      builder: (context, state) {
        if (state is TuningsLoadingState) {
          return const CircularProgressIndicator();
        }
        if (state is TuningsLoadedState) {
          return ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.lightNavBarSelected,
            ),
            child: Text(
              'Select Instrument',
              style: TextStyle(color: AppColors.lightAppBarText),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
