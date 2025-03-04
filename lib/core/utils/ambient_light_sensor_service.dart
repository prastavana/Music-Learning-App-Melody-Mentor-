// ambient_light_sensor_service.dart
import 'dart:async';

import 'package:sensors_plus/sensors_plus.dart';

class AmbientLightSensorService {
  StreamSubscription<LightSensorEvent>? _lightSubscription;

  void startListening(Function(double) onLightChanged) {
    try {
      _lightSubscription = lightSensorEvents.listen((LightSensorEvent event) {
        onLightChanged(event.value);
      });
    } catch (e) {
      print('Error starting light sensor: $e');
    }
  }

  void stopListening() {
    _lightSubscription?.cancel();
  }
}
