import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class ShakeDetector {
  static const double shakeThreshold = 15.0;
  static int lastShakeTime = 0;
  static StreamSubscription<AccelerometerEvent>? _subscription;

  static void startListening(BuildContext context) {
    _subscription = accelerometerEvents.listen((event) {
      double acceleration =
          sqrt(event.x * event.x + event.y * event.y + event.z * event.z);

      if (acceleration > shakeThreshold) {
        int currentTime = DateTime.now().millisecondsSinceEpoch;
        if (currentTime - lastShakeTime > 1000) {
          lastShakeTime = currentTime;
          _showReportDialog(context);
        }
      }
    });
  }

  static void _showReportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Report a Problem"),
        content: Text("Would you like to report a problem?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReportProblemScreen()));
            },
            child: Text("Report"),
          ),
        ],
      ),
    );
  }

  static void stopListening() {
    _subscription?.cancel();
  }
}

class ReportProblemScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Report Problem")),
      body: Center(child: Text("Report your issue here.")),
    );
  }
}
