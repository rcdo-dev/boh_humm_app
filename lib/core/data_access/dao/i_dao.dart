abstract interface class IDao<T> {
  Future<int?> insert({T? data});
  Future<T?> getById({int? id});
  Future<List<Map>?> getAll();
  Future<int?> update({required T data});
  Future<int?> delete({required T data});
}
