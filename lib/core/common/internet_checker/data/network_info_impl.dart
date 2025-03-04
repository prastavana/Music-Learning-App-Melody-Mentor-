// core/network/network_info_impl.dart
import 'package:connectivity_plus/connectivity_plus.dart';

import 'network_info.dart';

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl(this.connectivity);

  @override
  Future<bool> get isConnected async {
    final result = await connectivity.checkConnectivity();
    return result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi;
  }

  @override
  Stream<bool> get onConnectivityChanged async* {
    await for (final result in connectivity.onConnectivityChanged) {
      yield result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi;
    }
  }
}
