import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'internet_connectivity_cubit.dart';

void showInternetSnackbar(BuildContext context) {
  context.read<InternetConnectivityCubit>().checkConnectivity();

  BlocListener<InternetConnectivityCubit, InternetConnectivityState>(
    listener: (context, state) {
      if (state is InternetConnectivityLoaded) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.isConnected
                ? 'Internet Connected'
                : 'No Internet Connection'),
            backgroundColor: state.isConnected ? Colors.green : Colors.red,
          ),
        );
      } else if (state is InternetConnectivityError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Network Error: ${state.failure.runtimeType}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    },
    child: Container(), // Dummy child
  );
}
