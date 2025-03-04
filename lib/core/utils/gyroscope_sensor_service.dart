import 'dart:async';

import 'package:sensors_plus/sensors_plus.dart';

class GyroscopeSensorService {
  StreamSubscription<GyroscopeEvent>? _gyroscopeSubscription;
  final Function(double, double) onTiltChanged;

  GyroscopeSensorService({required this.onTiltChanged});

  void startListening() {
    _gyroscopeSubscription = gyroscopeEvents.listen((GyroscopeEvent event) {
      _handleGyroscopeChange(event.x, event.y, event.z);
    });
  }

  void stopListening() {
    _gyroscopeSubscription?.cancel();
  }

  void _handleGyroscopeChange(
      double rotationX, double rotationY, double rotationZ) {
    onTiltChanged(rotationX, rotationY);
  }
}
