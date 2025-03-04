// core/network/data_source.dart
abstract class DataSource<T> {
  Future<T> getRemoteData();
  Future<T> getLocalData();
}
