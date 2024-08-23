import 'package:sqflite/sqflite.dart';

import 'package:boh_humm/core/data_access/connection_db/i_connection_db.dart';
import 'package:boh_humm/core/data_access/dao/i_dao.dart';
import 'package:boh_humm/features/delivery/model/delivery_model.dart';

class DeliveryDao implements IDao<DeliveryModel> {
  final IConnectionDb connectionDb;

  DeliveryDao({
    required this.connectionDb,
  });

  @override
  Future<int?> insert({DeliveryModel? data}) async {
    Database database = await connectionDb.connectionDatabase();

    if (data != null) {
      try {
        int lastId = await database.rawInsert(
          "INSERT INTO delivery(del_order, del_fee, del_delr_id) values (?, ?, ?)",
          [data.del_order, data.del_fee, data.del_delr_id],
        );
        database.close();
        return lastId;
      } catch (e, s) {
        print('Exception: $e, StackTrace: $s');
      }
    }
    database.close();
    return null;
  }

  @override
  Future<List<Map>?> getAll() async {
    Database database = await connectionDb.connectionDatabase();
    var list = <Map>[];

    try {
      list = await database.rawQuery("SELECT * FROM delivery");
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
  Future<DeliveryModel?> getById({int? id}) async {
    Database database = await connectionDb.connectionDatabase();

    if (id != null) {
      try {
        var result = await database.rawQuery(
          "SELECT * FROM delivery WHERE del_id =?",
          [id],
        );

        if (result.isNotEmpty) {
          database.close();
          return DeliveryModel.fromMap(result.first);
        } else {
          database.close();
          return null;
        }
      } catch (e, s) {
        database.close();
        print('Exception: $e, StackTrace: $s');
      }
    }
    database.close();
    return null;
  }

  @override
  Future<int?> update({required DeliveryModel data}) async {
    Database database = await connectionDb.connectionDatabase();

    try {
      int id = await database.rawUpdate(
        "UPDATE delivery SET del_order = ?, del_fee = ? WHERE del_id = ?",
        [data.del_order, data.del_fee, data.del_id],
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
  Future<int?> delete({required DeliveryModel data}) async {
    Database database = await connectionDb.connectionDatabase();

    try {
      int id = await database.rawDelete(
        "DELETE FROM delivery WHERE del_id = ?",
        [data.del_id],
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