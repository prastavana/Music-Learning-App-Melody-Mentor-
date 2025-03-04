// shake_detector.dart
import 'dart:async';

import 'package:sensors_plus/sensors_plus.dart';

class ShakeDetector {
  static const Duration shakeDuration = Duration(milliseconds: 300);
  static const Duration resetDuration =
      Duration(milliseconds: 700); // Adjust as needed
  static const double shakeThreshold =
      25.0; // Increase this value significantly

  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;
  DateTime? _lastShakeTime;
  int shakeCount = 0;
  Timer? _resetTimer;

  void startListening(Function onShake, {double threshold = shakeThreshold}) {
    try {
      _accelerometerSubscription = accelerometerEvents.listen(
        (event) {
          double acceleration =
              event.x * event.x + event.y * event.y + event.z * event.z;
          if (acceleration >= threshold * threshold) {
            DateTime now = DateTime.now();
            if (_lastShakeTime == null ||
                now.difference(_lastShakeTime!) > shakeDuration) {
              _lastShakeTime = now;
              shakeCount++;

              if (shakeCount == 2) {
                onShake();
                shakeCount = 0;
                _resetTimer?.cancel();
              } else {
                _resetTimer?.cancel();
                _resetTimer = Timer(resetDuration, () {
                  shakeCount = 0;
                });
              }
            }
          }
        },
        onError: (error) {
          print('Error in accelerometer stream: $error');
        },
        cancelOnError: true,
      );
    } catch (e) {
      print('Error starting shake detection: $e');
    }
  }

  void stopListening() {
    try {
      _accelerometerSubscription?.cancel();
      _accelerometerSubscription = null;
      _resetTimer?.cancel();
    } catch (e) {
      print('Error stopping shake detection: $e');
    }
  }
}
