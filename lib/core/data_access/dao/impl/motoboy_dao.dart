import 'package:sqflite/sqflite.dart';

import 'package:motoboy_app_project/core/data_access/connection_db/i_connection_db.dart';
import 'package:motoboy_app_project/core/data_access/dao/i_dao.dart';
import 'package:motoboy_app_project/features/motoboy/model/motoboy_model.dart';

class MotoboyDao implements IDao<MotoboyModel> {
  final IConnectionDb connection;

  MotoboyDao({
    required this.connection,
  });

  @override
  Future<int?> insert({required MotoboyModel data}) async {
    Database database = await connection.connectionDatabase();

    try {
      int lastId = await database.rawInsert(
        "INSERT INTO motoboy(mot_name, mot_email, mot_image) VALUES (?, ?, ?)",
        [data.mot_name, data.mot_email, data.mot_image],
      );
      database.close();
      return lastId;
    } catch (e, s) {
      database.close();
      print('Exception: $e, StackTrace: $s');
    }
    database.close();
    return null;
  }

  @override
  Future<MotoboyModel?> getById({required int id}) async {
    Database database = await connection.connectionDatabase();

    try {
      var result = await database.rawQuery(
        "SELECT * FROM motoboy WHERE mot_id = ?",
        [id],
      );

      if (result.isNotEmpty) {
        database.close();
        return MotoboyModel.fromMap(result.first);
      }
      database.close();
    } catch (e, s) {
      database.close();
      print('Exception: $e, StackTrace: $s');
    }
    database.close();
    return null;
  }

  @override
  Future<List<Map>?> getAll() async {
    Database database = await connection.connectionDatabase();
    var list = <Map>[];

    try {
      list = await database.rawQuery('SELECT * FROM motoboy');
      if (list.isNotEmpty) {
        database.close();
        return list;
      }
      database.close();
    } catch (e, s) {
      database.close();
      print('Exception: $e, StackTrace: $s');
    }
    database.close();
    return null;
  }

  @override
  Future<int?> update({required MotoboyModel data}) async {
    Database database = await connection.connectionDatabase();

    try {
      int id = await database.rawUpdate(
        "UPDATE motoboy SET mot_email = ?, mot_image = ? WHERE mot_name = ?",
        [data.mot_email, data.mot_image, data.mot_name],
      );
      database.close();
      return id;
    } catch (e, s) {
      database.close();
      print('Exception: $e, StackTrace: $s');
    }
    database.close();
    return null;
  }

  @override
  Future<int?> delete({required MotoboyModel data}) async {
    Database database = await connection.connectionDatabase();

    try {
      int id = await database.rawDelete(
        "DELETE FROM motoboy WHERE mot_name = ?",
        [data.mot_name],
      );
      database.close();
      return id;
    } catch (e, s) {
      database.close();
      print('Exception: $e, StackTrace: $s');
    }
    database.close();
    return null;
  }
}
