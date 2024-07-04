abstract interface class IDao<T> {
  Future<int> insert({required T data});
  Future<T?> getById({required int id});
  Future<List<Map>?> getAll();
  Future<int> update({required T data});
  Future<void> delete({required int id});
}
