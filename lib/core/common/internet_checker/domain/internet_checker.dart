import 'package:music_learning_app/core/common/internet_checker/data/network_info.dart';

class InternetChecker {
  final NetworkInfo networkInfo;

  InternetChecker(this.networkInfo);

  Future<bool> get isConnected async {
    try {
      return await networkInfo.isConnected;
    } catch (e) {
      return false; // Return false if there's an error (e.g., no connectivity)
    }
  }
}
