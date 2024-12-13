import 'package:flutter/material.dart';
import 'package:music_learning_app/view/getting_started_view.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const GettingStartedView(),
        '/output': (context) => const GettingStartedView(),
      },
      debugShowCheckedModeBanner: false, // Correctly placed here
    ),
  );
}
