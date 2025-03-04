import 'package:flutter/material.dart';
import 'package:shake/shake.dart';

class ShakeService {
  // Function to start the shake detection
  static void startShakeDetection(BuildContext context) {
    ShakeDetector shakeDetector = ShakeDetector.autoStart(
      onPhoneShake: () {
        // Action when the phone is shaken
        _showReportDialog(context);
      },
    );
  }

  // Function to show a dialog when the shake is detected
  static void _showReportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Report a Problem"),
        content: const Text(
            "Thank you for reporting the problem! We will look into it."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
