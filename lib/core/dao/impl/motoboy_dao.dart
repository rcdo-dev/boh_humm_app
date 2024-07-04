import 'package:flutter_modular/flutter_modular.dart';
import 'package:motoboy_app_project/core/connection_db/connection_sqlite.dart';
import 'package:motoboy_app_project/core/dao/i_dao.dart';
import 'package:motoboy_app_project/features/motoboy/model/motoboy_model.dart';
import 'package:sqflite/sqflite.dart';

class MotoboyDao implements IDao<MotoboyModel> {
  @override
  Future<int> insert({required MotoboyModel data}) async {
    final connection = Modular.get<ConnectionSQlite>();
    Database database = await connection.connectionDatabase();

    int lastId = await database.insert(
      'motoboy',
      data.toMap(),
    );

    database.close();

    return lastId;
  }

  @override
  Future<MotoboyModel?> getById({required int id}) {
    throw UnimplementedError();
  }

  @override
  Future<List<Map>> getAll() {
    throw UnimplementedError();
  }

  @override
  Future<int> update({required MotoboyModel data}) {
    throw UnimplementedError();
  }

  @override
  Future<int> delete({required MotoboyModel data}) {
    throw UnimplementedError();
  }
}
