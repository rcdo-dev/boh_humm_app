abstract interface class IConnectionDb<T> {
  Future<T> connectionDatabase();
}
